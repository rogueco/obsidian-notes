# How to Fan-Out to Different SQS Queues Using SNS Message Filtering

Article Link: https://betterprogramming.pub/how-to-fan-out-to-different-sqs-queues-using-sns-message-filtering-84cd23ed9d07
Author: Lorenz Vanthillo
Date Added: August 26, 2021 2:49 PM
Tag: AWS

![https://miro.medium.com/max/1400/1*9i7kLcChRnlvmcbjo9MXUA.png](https://miro.medium.com/max/1400/1*9i7kLcChRnlvmcbjo9MXUA.png)

SNS-SQS Fan-out replicates a message to all subscribing queues (Image source: Author)

SNS and SQS are AWS services which are often used in an event-driven architecture. A combination of those services offers the possibility to fan-out messages. Often there is a need to filter these messages before replicating them to multiple queues. Now I want to explain a way to achieve this by taking full advantage of these AWS services and without the need to write any custom code.

Let’s start with a quick refresher on SNS-SQS fan-out. SNS is an AWS service that coordinates and manages the delivery or sending of messages to subscribing endpoints. It offers you the possibility **to **create **an “SNS topic” which is a logical access point that acts as a communication channel. By using AWS CLI, SDK, or the web console, you can start publishing messages to this topic. The SNS topic will forward the messages to its subscribers. One of the possible subscribers is SQS, which is the queuing service of AWS. You can subscribe multiple queues to the same topic to replicate a message over multiple queues. This is called fan-out.

The above scenario will replicate a message to all queues, and this allows for parallel asynchronous processing. Now what if you want to replicate messages to only some queues, depending on some message attributes? SNS offers a great solution for this case.

In this example, we will filter on two attributes:

- Color
- Number

The ColorQueue will receive all messages independent of the value of the color attribute. The BlueYellowQueue will receive all messages which have the attribute color set to blue or yellow. The RedQueue will only receive the messages with attribute color set to red. Last, there are two queues that can receive messages which have their attribute set to green. It depends on the second attribute (number) whether a message will end up on the GreenHighQueue (number > 100) or the GreenLowQueue (number ≤100).

![https://miro.medium.com/max/1400/1*O65a8ZTma4Xzh08QQWGyqQ.png](https://miro.medium.com/max/1400/1*O65a8ZTma4Xzh08QQWGyqQ.png)

Image source: Author

I’ve created a [CloudFormation template](https://github.com/lvthillo/sns-sqs-fanout/blob/master/template.yaml) so we can easily deploy this setup. The template contains the creation of the SNS topic and the SQS queues (and corresponding dead-letter queues). This is all pretty basic. A bit more advanced is the SQS policy. The policy grants our SNS topic the `SendMessage` permission for the five queues.

Now the only thing left is the creation of the SQS subscriptions to SNS. This is also the place where we define our filter policy.

The ColorQueue has no filter policy, and it just subscribes to the topic.

The other subscriptions contain filter policies. Here is the one for our BlueYellowQueue, which can receive a message that has the blue or the yellow color attribute.

The GreenHighQueue and the GreenLowQueue are using two filter policies. Below you can see the one for the GreenHighQueue.

You can use the following command to deploy the full stack.

```
$ aws cloudformation create-stack --template-body file://template.yaml --stack-name sns-sqs-fanout-filter-example
```

To verify if it works, we will publish a message to SNS. We start by publishing from the AWS web console.

![https://miro.medium.com/max/1400/1*CySgIWqm_Mx_Oo4S3pVo9A.png](https://miro.medium.com/max/1400/1*CySgIWqm_Mx_Oo4S3pVo9A.png)

The message is available on the ColorQueue and the RedQueue, just as we expect.

![https://miro.medium.com/max/1400/1*d-SYlNEWhKJ7hBjQGBofjA.png](https://miro.medium.com/max/1400/1*d-SYlNEWhKJ7hBjQGBofjA.png)

We used `RawMessageDelivery`, so we should receive the exact same message on our SQS Queue.

![https://miro.medium.com/max/1400/1*qAmJX05nsmPMkb64uxl_kw.png](https://miro.medium.com/max/1400/1*qAmJX05nsmPMkb64uxl_kw.png)

We can also inspect the attribute(s).

![https://miro.medium.com/max/1400/1*q48twhk6wJJT-1tMeJqEHQ.png](https://miro.medium.com/max/1400/1*q48twhk6wJJT-1tMeJqEHQ.png)

Now you can do something similar using AWS CLI:

```
$ aws sns publish \
--topic-arn "arn:aws:sns:eu-west-1:123456789012:Topic" \
--message "\"body\": \"{this is a test}\"" \
--message-attributes '{ "color":{ "DataType":"String","StringValue":"green" }, "number":{ "DataType":"Number","StringValue":"100"} }'
```

Again, we get the expected result. The message appears on the ColorQueue and the GreenLowQueue because the number attribute is lower than or equal to 100.

![https://miro.medium.com/max/1400/1*tgYkB8vgyGPxXS9xaA-Aig.png](https://miro.medium.com/max/1400/1*tgYkB8vgyGPxXS9xaA-Aig.png)

For a last example, I’ll use the Python SDK.

Again we see the expected result.

![https://miro.medium.com/max/1400/1*a41Wy1JaW9hV1r7zTeh23A.png](https://miro.medium.com/max/1400/1*a41Wy1JaW9hV1r7zTeh23A.png)

This basic example should have made clear how SNS filtering is working. We saw an example of AND logic (e.g., color is green and number > 100) and of OR logic (e.g., color is blue or yellow). Finally, we can go through a bit more advanced filtering examples.

For strings, you can have an exact match, like in our example case.

```
FilterPolicy:
  color:
    - green
```

You can also have the opposite, which means the policy matches any message attribute that doesn’t include any of the policy attribute values.

```
FilterPolicy:
  color:
    - anything-but:
      - green
```

You can also just check if a certain attribute is in place, without knowing the real value.

```
FilterPolicy:
  color:
    - exists: true
```

It’s also possible to check on a prefix of an attribute value.

```
FilterPolicy:
  color:
    - prefix: bas
```

For numeric attributes, it’s also possible to filter on a range. The following matches all numbers between 0 and 100.

```
FilterPolicy:
  number:
    - numeric:
      - ">"
      - 0
      - "<="
      - 100
```

When you want to update the filter policies in the AWS console, you’ll need to use the JSON notation. It’s also important to note that that filter policy updates aren’t implied immediately. Additions or changes to a subscription filter policy require up to 15 minutes to fully take effect.

![https://miro.medium.com/max/1400/1*p_NmpQGzcF3wEsZcBggjMg.png](https://miro.medium.com/max/1400/1*p_NmpQGzcF3wEsZcBggjMg.png)

By using SNS filter policies, you can easily filter on specific SNS attributes. There is no need to write custom code to customize your fan-out scenarios.

We went through a basic example and how to do the setup in CloudFormation. After that, we checked some more advanced filtering examples.

I hope you enjoyed it. Thank you for reading, and feel free to ask any questions!
# Adding Strategies

# Dynamic Form

When adding a strategy you need to do the following.

### 1.

### 2.

### 3.

### 4. Register the Strategy in the startup

**E.g:** 

```csharp
/// <summary>
/// Registers the SQS SNS strategies.
/// </summary>
/// <param name="services">Instance of <see cref="IServiceCollection"/>.</param>
private void RegisterSqsStrategies(IServiceCollection services)
{
    services.AddTransientWithName<IAwsSimpleQueueServiceMessageStrategy, SvcAgentUpdateAgentUserQStrategy>(AgentAwsSimpleNotificationServiceTopics.SvcAgentUpdateAgentUserQ.ToString());
}
```
# Text fields & Forms design — UI components series

Article Link: https://uxdesign.cc/text-fields-forms-design-ui-components-series-2b32b2beebd0
Date Added: March 22, 2021 3:00 PM
Tag: UI, UX

**F**orms have existed for a significant amount of time, greatly simplifying the task of drafting complaints and various other legal pleadings. With the advance of information and its processing, means to gather the data are also evolving. As printed forms were here for years we can learn a few tips from their design.

![https://miro.medium.com/max/4080/1*TPBE1TSVeFP17Moyy-m7SA.jpeg](https://miro.medium.com/max/4080/1*TPBE1TSVeFP17Moyy-m7SA.jpeg)

# **Text field anatomy**

Text fields allow users to enter text into a UI. They typically appear in forms and dialogs. Text field component design should provide a clear affordance for interaction, making the fields discoverable in layouts, efficient to fill in, and accessible.

![https://miro.medium.com/max/4080/1*JxHL9L6V08eS7x4M1l78uQ.jpeg](https://miro.medium.com/max/4080/1*JxHL9L6V08eS7x4M1l78uQ.jpeg)

**Here are key elements of the basic Text field:**1**. Container** — interactable input area2. **Input text** — entered into the text field3. **Label Text** — tell users what information belongs in a given form field4. **Placeholder text** — is a description or example of the information required that is replaced with input text after users provide it5. **Helper or Validation text(optional)** — provides additional context or validation message6. **Leading icon(optional)** — describe the type of input a text field requires7. **Trailing icon(optional)** — additional control for entered text, like clear, hide/show, etc

# **Text field types**

Most of them are based on basic text fields that were modified to better handle specific types of information, like the credit card numbers. Here are just a few examples of input types that are most commonly used throughout UIs we creating:

![https://miro.medium.com/max/5774/1*QgJxq8jKBSfYUVezVoOqGg.jpeg](https://miro.medium.com/max/5774/1*QgJxq8jKBSfYUVezVoOqGg.jpeg)

(*We specifically are not talking about few input types like checkboxes and radio buttons as we will cover them later in the series*)

# **Use appropriate input type for data you collecting**

Providing the right type of the text field for requested data will help users enter information in the right format and avoid mistakes, making the process as easy and efficient as possible.

![https://miro.medium.com/max/5774/1*WV1uAB17o4ocyoON3bWRkQ.jpeg](https://miro.medium.com/max/5774/1*WV1uAB17o4ocyoON3bWRkQ.jpeg)

# **Text fields have to change their appearance based on state and user interactions**

This can be done by providing visual cues that will communicate the state of the text field. Input text fields can have one of the following states: inactive, hover, disabled, focused, validation, error. All states should be clearly differentiated from one another, and consistent throughout the whole form and application. Better to follow best practices to not challenge formed user mental models.

![https://miro.medium.com/max/5776/1*tiXB_6Nz_uiJeMLKlwvu4w.jpeg](https://miro.medium.com/max/5776/1*tiXB_6Nz_uiJeMLKlwvu4w.jpeg)

# **Choosing the best text field style**

Usually, you will have three main options for label positioning: top, left, and right-aligned. The best style for you will depend on key goals and sizes of the form, components library, and platform you design for. All of them have some advantages and disadvantages.

![https://miro.medium.com/max/5774/1*2iSTRndDtaeVcLRPQZ6QCg.jpeg](https://miro.medium.com/max/5774/1*2iSTRndDtaeVcLRPQZ6QCg.jpeg)

Underline input popularized with original Material design guidelines are not the best option. There were already revised based on the large [Evolution of Material Design’s study](https://medium.com/google-design/the-evolution-of-material-designs-text-fields-603688b3fe03) that I recommend you to check out. Interestingly enough the same study showed that users prefer inputs with rounded corners.

# **Left-aligned labels**

A good choice when the data requested is unfamiliar for users

- **Advantages:** Easily scalable labels, good use of vertical space
- **Disadvantages:** Excesisbe and variable distance between labels and corresponding inputs increase completion time

![https://miro.medium.com/max/5776/1*T1EfAbSC53_vJOUvzJYehg.jpeg](https://miro.medium.com/max/5776/1*T1EfAbSC53_vJOUvzJYehg.jpeg)

# **Right-aligned labels**

Have nearly twice faster completion time vs left-aligned labels

- **Advantages:** Text field labels and input are closely positioned that limits number of eye movements resulting in fast completion time
- **Disadvantages:** Harder to quickly scan the form and understand what all information is required

![https://miro.medium.com/max/5776/1*XMSBGGGp8R89VyQVshfZrQ.jpeg](https://miro.medium.com/max/5776/1*XMSBGGGp8R89VyQVshfZrQ.jpeg)

# **Top aligned labels**

Fastest completion time and all-around best choice for the majority of the cases. Work well on mobile as they don't require a lot of horizontal space

- **Advantages:** Allow users to capture input label and input text with one single eye movement, fastest completion time
- **Disadvantages:** Require more vertical space

![https://miro.medium.com/max/5776/1*uVYLh3_IbRVNl0BYKPihcw.jpeg](https://miro.medium.com/max/5776/1*uVYLh3_IbRVNl0BYKPihcw.jpeg)

You can learn more on this topic [“Best practices for form design- by Luke Wroblewski”](http://static.lukew.com/webforms_lukew.pdf) and in [“ Label Placement in Forms — by Mateo Penzo”](https://www.uxmatters.com/mt/archives/2006/07/label-placement-in-forms.php)

# **Length of text field should be proportional to the expected user input**

Using identical input length for all text fields in your forms will make them visually pleasing but will be harder to complete.

![https://miro.medium.com/max/5776/1*-5V2e-jD2E0p1TXUSr0XiA.jpeg](https://miro.medium.com/max/5776/1*-5V2e-jD2E0p1TXUSr0XiA.jpeg)

# **Placeholders are not replacements for labels**

Disappearing placeholder text strains users’ short-term memory. Without labels, users cannot check all information they provided before submitting a form. If you want a very minimalist form design you can use the Material design floating labels approach.

Placeholder text inside the form can sometimes confuse users, better to use hint text outside the field.

![https://miro.medium.com/max/5774/1*jXge5Q-YGhkv_RenH72UmA.jpeg](https://miro.medium.com/max/5774/1*jXge5Q-YGhkv_RenH72UmA.jpeg)

# **Help users fill in forms**

- Help resolve partial queries with **Auto-Complete.** This ****happens within the input box where you type and you can press either enter or “right-arrow-key” to accept it.
- S earch a virtually unbounded list for related keywords and phrases with **Auto-Suggest.** This ****list appears as a multiple suggestion list in the form of the drop-down.
- **Pre-fill fields and use smart defaults.** Often you can easily detect a user’s country and the city by IP or geolocation. And based on most common scenarios and analytics you can define what should be selected by default. E-Commerce is an exception, don't preselect any preferences related to purchasing like size or color.

![https://miro.medium.com/max/5774/1*HfaQCS_dwWnaK5aj_JB0zg.jpeg](https://miro.medium.com/max/5774/1*HfaQCS_dwWnaK5aj_JB0zg.jpeg)

- **Provide contextual information.** If you know that in order to make the right decision or avoid mistakes users will need some additional information like an account balance when making a transfer, don’t hesitate to present it.

# **Use inline validation**

”Live inline validation” is where the validity of the user’s inputs are checked live as the user progresses through the form, as opposed to checking the inputs in a lump sum when the user submits the form. Implement it correctly to not do more harm:

- **Display validation messages** close to the input and all together
- **Don't shout on users**, error messages should tell users how to fix the problem instead of blaming them
- Avoid “**premature validation”** when the field ****is marked as invalid before they have finished typing
- Consider using **“positive validation”** it can add a sense of delight and progression

![https://miro.medium.com/max/5774/1*8Atlnx4svPg4RPoxGLrndw.jpeg](https://miro.medium.com/max/5774/1*8Atlnx4svPg4RPoxGLrndw.jpeg)

# **Reduce the number of fields**

It will remove the visual and cognitive load, and look much simpler.

- Don’t break text like Full name and Date into multiple fields
- Don't ask for the same info multiple times
- Work with labels and hints copy to shorten it as much as possible

![https://miro.medium.com/max/5774/1*IXE936q-tIDmJWaPhoUrug.jpeg](https://miro.medium.com/max/5774/1*IXE936q-tIDmJWaPhoUrug.jpeg)

# **Hide irrelevant fields**

By disclosing information progressively, we reveal only the essentials and help users manage the complexity only when they need to.

![https://miro.medium.com/max/5774/1*lDM8AZJ-gQQ9y2BKriV5Xw.jpeg](https://miro.medium.com/max/5774/1*lDM8AZJ-gQQ9y2BKriV5Xw.jpeg)

# **Use conditional logic**

Conditional logic allows automatically show or hide fields and skip pages in a form, based on visitor answers. This approach not only will reduce the number of fields but also make the fill-in process more personalized and conversation-like.

![https://miro.medium.com/max/5774/1*ZNb7IAY6AYS4nfrfBi7Y4Q.jpeg](https://miro.medium.com/max/5774/1*ZNb7IAY6AYS4nfrfBi7Y4Q.jpeg)

# **Group related fields**

One of the easiest ways to simplify complex forms is to start grouping related fields. There are multiple principles of grouping in Gestalt psychology that help items feel related: Proximity, Similarity, Continuity, Closure, and Connectedness. Grouping dozens of unstructured fields into few manageable sets will significantly increase form usability.

![https://miro.medium.com/max/5774/1*QkjktONINm3M73MVJ3FrkA.jpeg](https://miro.medium.com/max/5774/1*QkjktONINm3M73MVJ3FrkA.jpeg)

# **Avoid using multiple column layouts**

One column layout creates a clear path to completion for the user. Consequences of using a multi-column form layout include users skipping fields where they actually have data to input, inputting data into the wrong fields, or simply coming to a halt that can lead to abandonment.

![https://miro.medium.com/max/5776/1*V-xgJS-n4-h0nxCiJFPhVA.jpeg](https://miro.medium.com/max/5776/1*V-xgJS-n4-h0nxCiJFPhVA.jpeg)

# **Break complex forms into a few simple steps**

Sometimes even after removing everything unnecessary, some forms can get huge. Breaking up the huge tasks into a series of smaller looks much easier and motivates them to carry out the process to the end.

- **Display the steps and visually communicate progress** user makes, this gives more satisfaction and motivates to move forward
- **Don’t granulate the form**, too many steps will not help, just annoy users
- **Carry on a summary of key information provide** to reduce anxiety and need to have review step in the end

![https://miro.medium.com/max/5774/1*UXvtpc4M6NrdyWESW8q93Q.jpeg](https://miro.medium.com/max/5774/1*UXvtpc4M6NrdyWESW8q93Q.jpeg)

# **Minimize the ability to navigate outside of the wizard**

If the form is large enough to break into multiple steps, it deserves a separate clearly focused space to work with it. Exposing general navigation or any links that will disrupt the process will just create confusion. I would also advise against multi-step forms in small Pop-Ups.

![https://miro.medium.com/max/5776/1*rsTZyLktP5LjR2gk8hib6g.jpeg](https://miro.medium.com/max/5776/1*rsTZyLktP5LjR2gk8hib6g.jpeg)

# **Show the appropriate keyboard type**

Android or iOS provides several different keyboard types, each designed to facilitate a different type of input. To streamline data entry, the keyboard displayed when editing a text field should be appropriate to the type of content in the field. Be conscious of where the keyboard will appear. To not introduce scroll needlessly, position your text fields in the upper area.

![https://miro.medium.com/max/5776/1*eIsVLDYNTab6itS4Jgye-Q.jpeg](https://miro.medium.com/max/5776/1*eIsVLDYNTab6itS4Jgye-Q.jpeg)

# **Stop ridiculous password creation designs**

- Allow users to **unmask their password** instead of asking them to enter it 2 times, It will also work better for password generating apps
- **Display password requirements** all the time, and indicate users' progress towards meeting all the criteria. Try to simplify requirements for the user.
- Use **strength meters** encourage users to create stronger passwords

![https://miro.medium.com/max/5774/1*a0HcaLlOj_BaigsIQeMWCQ.jpeg](https://miro.medium.com/max/5774/1*a0HcaLlOj_BaigsIQeMWCQ.jpeg)
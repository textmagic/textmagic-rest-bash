[comment]: <> (HEAD)
# TextMagic BASH Wrapper
This library provides you with an easy way of sending SMS and receiving replies by integrating TextMagic SMS Gateway into your PHP application.

## What Is TextMagic?
TextMagic’s application programming interface (API) provides the communication link between your application and TextMagic’s SMS Gateway, allowing you to send and receive text messages and to check the delivery status of text messages you’ve already sent.

For detailed documentation and more examples, please visit [http://docs.textmagictesting.com/](http://docs.textmagictesting.com/).
[comment]: <> (/HEAD)

## Installation Instructions
1.  [Download](https://github.com/textmagic/textmagic-rest-bash) the latest version of the wrapper from GitHub.
2.  Put **tm.sh** into any folder or into PATH, if you want to use it globally.

## Requirements
The Shell wrapper for the TextMagic API has the following requirement:
*   Bash version 3 or newer.

## Send SMS via Shell (an example)
Run this in your command prompt or execute in script:
```bash
tm.sh send --text="Hello from TextMagic" --phones=447860021130
```
[comment]: <> (FOOTER)
## License
The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

[comment]: <> (/FOOTER)

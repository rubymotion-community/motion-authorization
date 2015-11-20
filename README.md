# Motion::Authorization

This gem provides simple authorization to your RubyMotion app. It was inspired by both [CanCan](https://github.com/ryanb/cancan) and [Pundit](https://github.com/elabs/pundit). There are no dependencies, so it should work in all kinds of RubyMotion apps. Permissions are defined as "policy" classes (like Pundit) and queried with a syntax similar to CanCan.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "motion-authorization"
```

And then execute:

    $ bundle

Be sure to `require "motion-authorization"` in your Rakefile (unless you are using `Bundler.require`).

## Usage

### Step 1: Specify the current user.

This gem provides two different ways to specify the current user: directly or as a callback to be evaluated later. If setting directly, you will want to do that when the current user changes. Assuming you already have a method for fetching your current user, you can hook into your existing method by defining the `current_user_method` as a block.

```ruby
Motion::Authorization.current_user = current_user_instance
# OR...
Motion::Authorization.current_user_method do
  MyAuthClass.current_user
end
```

### Step 2: Include the DSL methods.

In any class where you want to check if the current user is authorized to do something, start by including the DSL methods:

```ruby
class MyRubyMotionClass
  include Motion::Authorization::Methods
  # ...
end
```

Now you can use one of Motion::Authorization's query methods to check if the current user can do something. Let's say that we have a `SecretMessage` object, and we only want to display it if the current user is able to view it.

```ruby
display_secret_message if can? :view, secret_message
```

Motion::Authorization provides several methods to choose from that may (or may not) make your code easier to read.

* `can?`
* `permitted_to?`
* `authorized_to?`
* `authorised_to?`

Choose the method which you like best.

### Step 3: Define a Policy class.

Extending our previous example of `can? :view, secret_message`, Motion::Authorization will look for a class named `SecretMessagePolicy` with a method named `view?` which returns true or false.

Policy classes in Motion::Authorization are identical to those in [Pundit](https://github.com/elabs/pundit). Typically, you will create a class within a `policies` directory, such as `app/policies/secret_message_policy.rb`. Next, you would define a class that accepts the current user and object that it is related to. Something like this:

```ruby
class SecretMessagePolicy
  attr_accessor :user, :secret_message

  def initialize(user, secret_message)
    @user = user
    @secret_message = secret_message
  end

  def view?
    user.id == secret_message.owner.id
  end
end
```

Or even more simply by using `Struct`:


```ruby
class SecretMessagePolicy < Struct.new(:user, :secret_message)
  def view?
    user.id == secret_message.owner.id
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andrewhavens/motion-authorization.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

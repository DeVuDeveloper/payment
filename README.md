# Web Payment System with Braintree and GraphQL.
This web payment system integrates Braintree for payment processing using GraphQL. It consists of two main components: `ChargesController` for processing user payments and `Admin::PaymentsController` for displaying transactions.

![Payment1](app/assets/images/screenb.png) | ![Payment2](app/assets/images/screenb2.png)
:-------------------------:|:-------------------------:
Payment1           | Payment2 

## Introduction

his web payment system is built with Ruby on Rails and Braintree, a popular payment gateway. It allows users to make payments securely and administrators to view transaction details. The system uses GraphQL for communication with the Braintree gateway.

## Additional Resources

For more in-depth information and best practices on implementing Web Payment System in Ruby on Rails, check out our comprehensive article:

[Web Payment System in Ruby on Rails - Best Practices](https://medium.com/@dejanvu.developer/implementing-web-push-notifications-in-a-ruby-on-rails-application-dcd829e02df0)

## Features

- **User Payment Processing**: Users can make payments securely using Braintree.
- **Admin Transaction List**: Administrators can view a list of successful transactions.
- **GraphQL Integration**: The system uses GraphQL to communicate with Braintree.

## Installation

### Prerequisites

- Ruby on Rails should be installed.
- You need a Braintree account and API credentials.
- Set up your Rails application and configure your database.


### Installation Steps

Clone this repository to your local development environment:

1. Clone the repository:

```bash
git clone https://github.com/DeVuDeveloper/payment.git
cd payment

2. Install the required gems:

```bash
 bundle install
 bin/setup
```

3. Set up the database:

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```

4. Set up your Braintree credentials in the .env file(or Rails Credentials):

```bash
  BRAINTREE_MERCHANT_ID=your_merchant_id
  BRAINTREE_PUBLIC_KEY=your_public_key
  BRAINTREE_PRIVATE_KEY=your_private_key
```

5. Run the server(Open your Browser and navigate to url: http://localhost:3000/): 

```bash
  bin/dev
```

## Linter

The Push Notifications App a linter. You can run the linter with the following command:

```bash
  rubocop && rubocop -A
```

## Testsing
To ensure that your web payment system works correctly, follow these testing steps:

1. Install any required testing dependencies if you haven't already.

2. Execute the tests to verify that transactiaons are made and displayed as expected.

```bash
  rspec spec
```

### Usage

**ChargesController**

The `ChargesController` handles user payments. It uses Braintree for processing transactions and GraphQL for communication.

- `GET /charges/new`: Renders the payment page.
- `POST /charges`: Processes the payment and redirects to a new payment page with a success message if the transaction is successful.

**Admin::PaymentsController**

The `Admin::PaymentsController` is for administrators to view transaction details.

- `GET /admin/payments`: Lists successful transactions.


## Built With 🔨

<div align="center">

|     | Languages                                                                                                                                                                                                                                                                                                                  |     |
| --- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
|     | ![Ruby](https://img.shields.io/badge/-Ruby-000000?style=flat&logo=ruby&logoColor=red)![Ruby on Rails](https://img.shields.io/badge/-Ruby_on_Rails-000000?style=flat&logo=ruby-on-rails&logoColor=blue)![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white)!![JavaScript](https://img.shields.io/badge/javascript-%23316192.svg?style=for-the-badge&logo=javascript&logoColor=white)![Stimulus](https://img.shields.io/badge/Stimulus-%23316192.svg?style=for-the-badge&logo=javascript&logoColor=white) |

<div align="center">


|     | Tools 🛠️                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |     |
| --- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- |
|     | ![RSpec](https://img.shields.io/badge/RSpec-%23FF5545.svg?style=for-the-badge&logo=ruby&logoColor=white)![Jest](https://img.shields.io/badge/Jest-%23C21325.svg?style=for-the-badge&logo=jest&logoColor=white)![Git](https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white) ![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white) ![Markdown](https://img.shields.io/badge/markdown-%23000000.svg?style=for-the-badge&logo=markdown&logoColor=white) ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white) |     |

<p align="right">(<a href="#top">back to top</a>)</p>
</div>

## Authors ✍️

<div align="center">

| 👤 DeVuDeveloper|
| -------- |

| <a target="_blank" href="https://github.com/DeVuDeveloper"><img src="https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white" alt="Github profile"></a> <a target="_blank" href="https://www.linkedin.com/in/devuj/"><img src="https://img.shields.io/badge/-LinkedIn-0077b5?style=for-the-badge&logo=LinkedIn&logoColor=white" alt="Linkedin profile"></a> <a target="_blank" href="https://twitter.com/DejanVuj"><img src="https://img.shields.io/badge/-Twitter-1DA1F2?style=for-the-badge&logo=Twitter&logoColor=white" alt="Twitter profile"></a>
|

</div>

<p align="right">(<a href="#top">back to top</a>)</p>

## Acknowledgments

- Braintree

Happy coding!


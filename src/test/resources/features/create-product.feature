Feature: Create Product

Background:
  * url 'https://api.escuelajs.co/api/v1/products'
  * def productPayload =
    """
    {
      "title": "Sample Test 1",
      "price": 65,
      "description": "This is a test product created using Karate",
      "categoryId": 1,
      "images": ["https://placeimg.com/640/480/any"]
    }
    """

Scenario: Create a new product (POST)
  Given request productPayload
  When method POST
  * print response
  * print responseStatus
  Then status 201
  And match response.title == productPayload.title
  * print response.title
  * def productId = response.id
  * def productTitle = response.title
  * def productPrice = response.price
  * def productdescription = response.description
  * print productId
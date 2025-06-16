Feature: CRUD operations on Product API

Background:
  * def createResult = callonce read('classpath:features/create-product.feature')
  * def productId = createResult.productId
  * def productTitle = createResult.productTitle
  * def productPrice = createResult.productPrice
  * def productdescription = createResult.productdescription
  * url 'https://api.escuelajs.co/api/v1/products'

@Positive_Scenario
Scenario: Get the created product (GET)
  Given path productId
  When method GET
  * print response
  * print responseStatus
  Then status 200
  And match response.title == productTitle
  And match response.price == productPrice
  And match response.description == productdescription

@Positive_Scenario
Scenario: Update the product (PUT)
  * def updatedPayload =
    """
    {
      "title": "#(productTitle)",
      "price": 56,
      "description": "Updated description using Karate",
      "categoryId": 1,
      "images": ["https://placeimg.com/640/480/tech"]
    }
    """
  Given path productId
  And request updatedPayload
  When method PUT
  * print response
  * print responseStatus
  Then status 200
  And match response.title == productTitle
  And match response.price == 56
  And match response.description == "Updated description using Karate"

@Positive_Scenario
Scenario: Delete the product (DELETE)
  Given path productId
  When method DELETE
  * print response
  * print responseStatus
  Then status 200

@Positive_Scenario
Scenario: Verify product has been deleted (GET)
  Given path productId
  When method GET
  * print response
  * print responseStatus
  Then status 400

@Negative_Scenario
Scenario: Get product with invalid ID
  Given path 'invalid-id'
  When method GET
  Then status 400
  * print response
  

@Negative_Scenario
Scenario: Get product with non-existent numeric ID
  Given path 9999999
  When method GET
  Then status 400
  * print response

@Negative_Scenario
Scenario: Update product with invalid data
  * def badPayload =
    """
    {
      "title": "",
      "price": -10,
      "description": 12345,
      "categoryId": "invalid",
      "images": ["not-a-url"]
    }
    """
  Given path productId
  And request badPayload
  When method PUT
  Then status 400
  * print response

@Negative_Scenario
Scenario: Delete product with non-existent ID
  Given path 9999999
  When method DELETE
  Then status 400
* print response
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using backend_api.Models;
using Xunit;
using Microsoft.AspNetCore.Diagnostics;
using Microsoft.AspNetCore.TestHost;
using System.Net.Http;
using Microsoft.AspNetCore.Hosting;

namespace backend_api.Tests
{
    public class UserIntegrationTest : IClassFixture<TestFixture<Startup>>
    {
        private HttpClient Client;

        public UserIntegrationTest(TestFixture<Startup> fixture)
        {
            Client = fixture.Client;
        }

        [Fact]
        public async Task TestGetUsersAsync()
        {
            // Arrange
            var request = "/api/User";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
            //Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
        /*
        [Fact]
        public async Task TestGetStockItemAsync()
        {
            // Arrange
            var request = "/api/v1/Warehouse/StockItem/1";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            response.EnsureSuccessStatusCode();
        }
        */
        [Fact]
        public async Task TestPostUserAsync()
        {
            // Arrange
            var request = new
            {
                Url = "/api/User",
                Body = new
                {
                    userID = 1,
                    firstname = "Integration",
                    lastname = "test1",
                    phoneNumber = "1234567890",
                    pinnedUserIDs = new List<int>{1,2},
                    userImage = "Image.png",
                    userDescription = "Integration test user",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 4,
                    userRoles = 0,
                    officeLocation = 0,
                    userEmails = new List<int>{1},
                    //Tags = "[\"32GB\",\"USB Powered\"]"
                    /*"userID": 0,
                    "firstname": "string",
                    "lastname": "string",
                    "phoneNumber": "string",
                    "pinnedUserIDs": [
                    0
                    ],
                    "userImage": "string",
                    "userDescription": "string",
                    "isOnline": true,
                    "isAdmin": true,
                    "employeeLevel": 0,
                    "userRoles": 0,
                    "officeLocation": 0,
                    "userEmails": [
                    0
                    ] */
                }
            };

            // Act
            var response = await Client.PostAsync(request.Url, ContentHelper.GetStringContent(request.Body));
            var value = await response.Content.ReadAsStringAsync();

            // Assert
            response.EnsureSuccessStatusCode();
        }
        /*
        [Fact]
        public async Task TestPutStockItemAsync()
        {
            // Arrange
            var request = new
            {
                Url = "/api/v1/Warehouse/StockItem/1",
                Body = new
                {
                    StockItemName = string.Format("USB anime flash drive - Vegeta {0}", Guid.NewGuid()),
                    SupplierID = 12,
                    Color = 3,
                    UnitPrice = 39.00m
                }
            };

            // Act
            var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));

            // Assert
            response.EnsureSuccessStatusCode();
        }

        [Fact]
        public async Task TestDeleteStockItemAsync()
        {
            // Arrange

            var postRequest = new
            {
                Url = "/api/v1/Warehouse/StockItem",
                Body = new
                {
                    StockItemName = string.Format("Product to delete {0}", Guid.NewGuid()),
                    SupplierID = 12,
                    UnitPackageID = 7,
                    OuterPackageID = 7,
                    LeadTimeDays = 14,
                    QuantityPerOuter = 1,
                    IsChillerStock = false,
                    TaxRate = 10.000m,
                    UnitPrice = 10.00m,
                    RecommendedRetailPrice = 47.84m,
                    TypicalWeightPerUnit = 0.050m,
                    CustomFields = "{ \"CountryOfManufacture\": \"USA\", \"Tags\": [\"Sample\"] }",
                    Tags = "[\"Sample\"]",
                    SearchDetails = "Product to delete",
                    LastEditedBy = 1,
                    ValidFrom = DateTime.Now,
                    ValidTo = DateTime.Now.AddYears(5)
                }
            };

            // Act
            var postResponse = await Client.PostAsync(postRequest.Url, ContentHelper.GetStringContent(postRequest.Body));
            var jsonFromPostResponse = await postResponse.Content.ReadAsStringAsync();

            var singleResponse = JsonConvert.DeserializeObject<SingleResponse<StockItem>>(jsonFromPostResponse);

            var deleteResponse = await Client.DeleteAsync(string.Format("/api/v1/Warehouse/StockItem/{0}", singleResponse.Model.StockItemID));

            // Assert
            postResponse.EnsureSuccessStatusCode();

            Assert.False(singleResponse.DidError);

            deleteResponse.EnsureSuccessStatusCode();
        }*/
    }
}
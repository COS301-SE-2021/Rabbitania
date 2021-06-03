using System;
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
    public class NoticeBoardThreadTest : IClassFixture<TestFixture<Startup>>
    {
        private HttpClient Client;

        public NoticeBoardThreadTest(TestFixture<Startup> fixture)
        {
            Client = fixture.Client;
        }

        [Fact]
        public async Task TestGetNoticeBoardAsync()
        {
            // Arrange
            var request = "api/NoticeBoardThread";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            //response.EnsureSuccessStatusCode();
            Assert.Equal(HttpStatusCode.OK, response.StatusCode);
        }
        
        
        /*[Fact]
        public async Task TestGetNoticeBoardThreadNotFoundAsync()
        {
            // Arrange
            var request = "api/NoticeBoardThread/1";

            // Act
            var response = await Client.GetAsync(request);

            // Assert
            Assert.Equal(HttpStatusCode.BadRequest, response.StatusCode);
        }*/


        [Fact]
        public async Task TestPutNoticeBoardThreadNotFoundAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/NoticeBoardThread/1",
                Body= new
                {
                    threadID= 0,
                    threadTitle= "tesTitle",
                    threadContent= "test thread content",
                    threadCreationDate= "2021/05/21",
                    threadDueDate= "2021/05/21",
                    userID= 0
                }
            };

        // Act
        var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));
        
        // Assert
        Assert.Equal(HttpStatusCode.BadRequest,response.StatusCode);
        }
        
        
        [Fact]
        public async Task TestNoticeBoardThreadPostAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/NoticeBoardThread",
                Body= new
                {
                    threadID= 0,
                    threadTitle= "tesTitle",
                    threadContent= "test thread content",
                    threadCreationDate= "2021/05/21",
                    threadDueDate= "2021/05/21",
                    userID= 0
                }
            };

            // Act
            var response = await Client.PostAsync(request.Url,ContentHelper.GetStringContent(request.Body));

            // Assert
            response.EnsureSuccessStatusCode();
        }
        
        [Fact]
        public async Task TestPutNoticeBoardThreadAsync()
        {
            // Arrange
            var request = new
            {
                Url = "api/NoticeBoardThread/0",
                Body= new
                {
                    threadID= 0,
                    threadTitle= "newTestTitleForUpdate",
                    threadContent= "test thread content",
                    threadCreationDate= "2021/05/21",
                    threadDueDate= "2021/05/21",
                    userID= 0
                }
            };

            // Act
            var response = await Client.PutAsync(request.Url, ContentHelper.GetStringContent(request.Body));
        
            // Assert
            Assert.Equal(HttpStatusCode.NotFound,response.StatusCode);
        }

        [Fact]
        public async Task TestDeleteNoticeBoardThreadByID()
        {
            //arrange
            var request = "api/NoticeBoardThread/0";
            //act
            var response = await Client.DeleteAsync(request);
            //assert
            response.EnsureSuccessStatusCode();
        }


        /*
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
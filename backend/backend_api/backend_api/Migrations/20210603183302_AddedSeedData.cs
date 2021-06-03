using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class AddedSeedData : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "users",
                columns: new[] { "UserID", "employeeLevel", "firstname", "isAdmin", "isOnline", "lastname", "officeLocation", "phoneNumber", "pinnedUserIDs", "userDescription", "userImage", "userRoles" },
                values: new object[,]
                {
                    { 1112, 4, "Matthew", true, true, "Harty", 0, "0834855754", null, "Hello there", "image.png", 0 },
                    { 1113, 6, "Castello", true, false, "Govender", 0, "0861830383", null, "Hey there!", "image2.png", 1 },
                    { 1114, 5, "James", false, false, "Hulett", 0, "0794756432", null, "Love gaming", "image3.png", 3 },
                    { 1115, 3, "Dean", true, true, "Nortje", 0, "08374646378", null, "Keep moving forward - Standard Bank", "image4.png", 5 },
                    { 1116, 2, "Joe", true, false, "Harraway", 0, "0112345667", null, "Love coding", "image5.png", 2 },
                    { 1117, 5, "DeVilliers", false, false, "Meiring", 0, "08611112567", null, "Fighting life", "image1.png", 0 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1112);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1113);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1114);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1115);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1116);

            migrationBuilder.DeleteData(
                table: "users",
                keyColumn: "UserID",
                keyValue: 1117);
        }
    }
}

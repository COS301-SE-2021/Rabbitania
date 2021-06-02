using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class NoticeBoardthreadMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "noticeBoardThreads",
                columns: table => new
                {
                    threadID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    threadTitle = table.Column<string>(type: "text", nullable: true),
                    threadContent = table.Column<string>(type: "text", nullable: true),
                    UserID = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_noticeBoardThreads", x => x.threadID);
                });

            migrationBuilder.CreateTable(
                name: "users",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    email = table.Column<string>(type: "text", nullable: true),
                    firstname = table.Column<string>(type: "text", nullable: true),
                    lastname = table.Column<string>(type: "text", nullable: true),
                    phoneNumber = table.Column<string>(type: "text", nullable: true),
                    pinnedUserIDs = table.Column<List<int>>(type: "integer[]", nullable: true),
                    userImage = table.Column<string>(type: "text", nullable: true),
                    userDescription = table.Column<string>(type: "text", nullable: true),
                    isOnline = table.Column<bool>(type: "boolean", nullable: false),
                    isAdmin = table.Column<bool>(type: "boolean", nullable: false),
                    employeeLevel = table.Column<int>(type: "integer", nullable: false),
                    userRoles = table.Column<int>(type: "integer", nullable: false),
                    officeLocation = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_users", x => x.UserID);
                });

            migrationBuilder.InsertData(
                table: "users",
                columns: new[] { "UserID", "email", "employeeLevel", "firstname", "isAdmin", "isOnline", "lastname", "officeLocation", "phoneNumber", "pinnedUserIDs", "userDescription", "userImage", "userRoles" },
                values: new object[,]
                {
                    { 1, "mattharty@retrorabbit.co.za", 4, "Matthew", true, true, "Harty", 0, "0834855754", null, "Hello there", "image.png", 0 },
                    { 2, "rorymcilroy@retrorabbit.co.za", 5, "Rory", false, false, "McIlroy", 0, "0113445667", null, "Love golf.", "image1.png", 2 },
                    { 3, "cgovender@retrorabbit.co.za", 6, "Castello", true, false, "Govender", 0, "0861830383", null, "Hey there!", "image2.png", 1 },
                    { 4, "jameshulett@retrorabbit.co.za", 5, "James", false, false, "Hulett", 0, "0794756432", null, "Love gaming", "image3.png", 3 },
                    { 5, "deannortje@retrorabbit.co.za", 3, "Dean", true, true, "Nortje", 0, "08374646378", null, "Keep moving forward - Standard Bank", "image4.png", 5 },
                    { 6, "josephharraway@retrorabbit.co.za", 2, "Joe", true, false, "Harraway", 0, "0112345667", null, "Love coding", "image5.png", 2 },
                    { 7, "devilliersmeiring@retrorabbit.co.za", 5, "DeVilliers", false, false, "Meiring", 0, "08611112567", null, "Fighting life", "image1.png", 0 }
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "noticeBoardThreads");

            migrationBuilder.DropTable(
                name: "users");
        }
    }
}

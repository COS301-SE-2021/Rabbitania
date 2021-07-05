using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Data.Migrations
{
    public partial class InitialUserCreation : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Users",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    Name = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber = table.Column<string>(type: "text", nullable: true),
                    PinnedUserIds = table.Column<List<int>>(type: "integer[]", nullable: true),
                    UserImgUrl = table.Column<string>(type: "text", nullable: true),
                    UserDescription = table.Column<string>(type: "text", nullable: true),
                    IsAdmin = table.Column<bool>(type: "boolean", nullable: false),
                    EmployeeLevel = table.Column<int>(type: "integer", nullable: false),
                    UserRole = table.Column<int>(type: "integer", nullable: false),
                    OfficeLocation = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Users", x => x.UserId);
                });

            migrationBuilder.CreateTable(
                name: "UserEmails",
                columns: table => new
                {
                    UserEmailId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    UserEmail = table.Column<string>(type: "text", nullable: true),
                    UserId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserEmails", x => x.UserEmailId);
                    table.ForeignKey(
                        name: "FK_UserEmails_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserEmails_UserId",
                table: "UserEmails",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserEmails");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}

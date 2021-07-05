using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Data.Migrations
{
    public partial class UserForeignKeyInForum : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "ForumThreads",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "UsersUserId",
                table: "ForumThreads",
                type: "integer",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "UserId",
                table: "Forums",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddColumn<int>(
                name: "UsersUserId",
                table: "Forums",
                type: "integer",
                nullable: true);

            /*
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
                */

            migrationBuilder.CreateIndex(
                name: "IX_ForumThreads_UsersUserId",
                table: "ForumThreads",
                column: "UsersUserId");

            migrationBuilder.CreateIndex(
                name: "IX_Forums_UsersUserId",
                table: "Forums",
                column: "UsersUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Forums_Users_UsersUserId",
                table: "Forums",
                column: "UsersUserId",
                principalTable: "Users",
                principalColumn: "UserId",
                onDelete: ReferentialAction.Restrict);

            migrationBuilder.AddForeignKey(
                name: "FK_ForumThreads_Users_UsersUserId",
                table: "ForumThreads",
                column: "UsersUserId",
                principalTable: "Users",
                principalColumn: "UserId",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Forums_Users_UsersUserId",
                table: "Forums");

            migrationBuilder.DropForeignKey(
                name: "FK_ForumThreads_Users_UsersUserId",
                table: "ForumThreads");

            migrationBuilder.DropTable(
                name: "Users");

            migrationBuilder.DropIndex(
                name: "IX_ForumThreads_UsersUserId",
                table: "ForumThreads");

            migrationBuilder.DropIndex(
                name: "IX_Forums_UsersUserId",
                table: "Forums");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "ForumThreads");

            migrationBuilder.DropColumn(
                name: "UsersUserId",
                table: "ForumThreads");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Forums");

            migrationBuilder.DropColumn(
                name: "UsersUserId",
                table: "Forums");
        }
    }
}

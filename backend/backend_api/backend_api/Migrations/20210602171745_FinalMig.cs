using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class FinalMig : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_users_UserEmails_userEmailsID",
                table: "users");

            migrationBuilder.DropIndex(
                name: "IX_users_userEmailsID",
                table: "users");

            migrationBuilder.DropPrimaryKey(
                name: "PK_UserEmails",
                table: "UserEmails");

            migrationBuilder.DropColumn(
                name: "userEmailsID",
                table: "users");

            migrationBuilder.RenameTable(
                name: "UserEmails",
                newName: "userEmails");

            migrationBuilder.AddColumn<List<int>>(
                name: "UserEmails",
                table: "users",
                type: "integer[]",
                nullable: true);

            migrationBuilder.AddPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails",
                column: "userEmailsID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails");

            migrationBuilder.DropColumn(
                name: "UserEmails",
                table: "users");

            migrationBuilder.RenameTable(
                name: "userEmails",
                newName: "UserEmails");

            migrationBuilder.AddColumn<int>(
                name: "userEmailsID",
                table: "users",
                type: "integer",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.AddPrimaryKey(
                name: "PK_UserEmails",
                table: "UserEmails",
                column: "userEmailsID");

            migrationBuilder.CreateIndex(
                name: "IX_users_userEmailsID",
                table: "users",
                column: "userEmailsID");

            migrationBuilder.AddForeignKey(
                name: "FK_users_UserEmails_userEmailsID",
                table: "users",
                column: "userEmailsID",
                principalTable: "UserEmails",
                principalColumn: "userEmailsID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}

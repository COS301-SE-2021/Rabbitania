using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class DeletedUserEmailOutOfUser : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UserEmails",
                table: "users");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<List<int>>(
                name: "UserEmails",
                table: "users",
                type: "integer[]",
                nullable: true);
        }
    }
}

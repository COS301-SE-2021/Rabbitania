using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class AddedUserLink : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateIndex(
                name: "IX_userEmails_UserID",
                table: "userEmails",
                column: "UserID");

            migrationBuilder.AddForeignKey(
                name: "FK_userEmails_users_UserID",
                table: "userEmails",
                column: "UserID",
                principalTable: "users",
                principalColumn: "UserID",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_userEmails_users_UserID",
                table: "userEmails");

            migrationBuilder.DropIndex(
                name: "IX_userEmails_UserID",
                table: "userEmails");
        }
    }
}

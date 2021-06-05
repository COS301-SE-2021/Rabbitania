using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class AddedUserIDToUserEmails : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails");

            migrationBuilder.RenameColumn(
                name: "userEmailsID",
                table: "userEmails",
                newName: "UserID");

            migrationBuilder.AlterColumn<int>(
                name: "UserID",
                table: "userEmails",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .OldAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddColumn<int>(
                name: "userEmailID",
                table: "userEmails",
                type: "integer",
                nullable: false,
                defaultValue: 0)
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails",
                column: "userEmailID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails");

            migrationBuilder.DropColumn(
                name: "userEmailID",
                table: "userEmails");

            migrationBuilder.RenameColumn(
                name: "UserID",
                table: "userEmails",
                newName: "userEmailsID");

            migrationBuilder.AlterColumn<int>(
                name: "userEmailsID",
                table: "userEmails",
                type: "integer",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "integer")
                .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            migrationBuilder.AddPrimaryKey(
                name: "PK_userEmails",
                table: "userEmails",
                column: "userEmailsID");
        }
    }
}

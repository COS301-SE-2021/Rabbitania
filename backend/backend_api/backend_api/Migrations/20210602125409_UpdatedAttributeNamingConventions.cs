using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class UpdatedAttributeNamingConventions : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "threadTitle",
                table: "noticeBoardThreads",
                newName: "ThreadTitle");

            migrationBuilder.RenameColumn(
                name: "threadDueDate",
                table: "noticeBoardThreads",
                newName: "ThreadDueDate");

            migrationBuilder.RenameColumn(
                name: "threadCreationDate",
                table: "noticeBoardThreads",
                newName: "ThreadCreationDate");

            migrationBuilder.RenameColumn(
                name: "threadContent",
                table: "noticeBoardThreads",
                newName: "ThreadContent");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "ThreadTitle",
                table: "noticeBoardThreads",
                newName: "threadTitle");

            migrationBuilder.RenameColumn(
                name: "ThreadDueDate",
                table: "noticeBoardThreads",
                newName: "threadDueDate");

            migrationBuilder.RenameColumn(
                name: "ThreadCreationDate",
                table: "noticeBoardThreads",
                newName: "threadCreationDate");

            migrationBuilder.RenameColumn(
                name: "ThreadContent",
                table: "noticeBoardThreads",
                newName: "threadContent");
        }
    }
}

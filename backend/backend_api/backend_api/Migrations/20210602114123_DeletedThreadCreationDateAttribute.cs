using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class DeletedThreadCreationDateAttribute : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "threadCreationDate",
                table: "noticeBoardThreads");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "threadCreationDate",
                table: "noticeBoardThreads",
                type: "text",
                nullable: true);
        }
    }
}

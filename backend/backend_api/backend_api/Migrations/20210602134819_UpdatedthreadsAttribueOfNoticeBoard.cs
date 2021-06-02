using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class UpdatedthreadsAttribueOfNoticeBoard : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "NoticeBoardID",
                table: "noticeBoardThreads",
                type: "integer",
                nullable: true);

            migrationBuilder.CreateIndex(
                name: "IX_noticeBoardThreads_NoticeBoardID",
                table: "noticeBoardThreads",
                column: "NoticeBoardID");

            migrationBuilder.AddForeignKey(
                name: "FK_noticeBoardThreads_noticeBoard_NoticeBoardID",
                table: "noticeBoardThreads",
                column: "NoticeBoardID",
                principalTable: "noticeBoard",
                principalColumn: "NoticeBoardID",
                onDelete: ReferentialAction.Restrict);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_noticeBoardThreads_noticeBoard_NoticeBoardID",
                table: "noticeBoardThreads");

            migrationBuilder.DropIndex(
                name: "IX_noticeBoardThreads_NoticeBoardID",
                table: "noticeBoardThreads");

            migrationBuilder.DropColumn(
                name: "NoticeBoardID",
                table: "noticeBoardThreads");
        }
    }
}

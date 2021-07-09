using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Data.Migrations
{
    public partial class InitialNoticeContext : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            /*migrationBuilder.CreateTable(
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
                });*/

            migrationBuilder.CreateTable(
                name: "NoticeBoard",
                columns: table => new
                {
                    ThreadId = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ThreadTitle = table.Column<string>(type: "text", nullable: true),
                    ThreadContent = table.Column<string>(type: "text", nullable: true),
                    MinEmployeeLevel = table.Column<int>(type: "integer", nullable: false),
                    ImageUrl = table.Column<string>(type: "text", nullable: true),
                    PermittedUserRoles = table.Column<int>(type: "integer", nullable: false),
                    UserId = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_NoticeBoard", x => x.ThreadId);
                    table.ForeignKey(
                        name: "FK_NoticeBoard_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "UserId",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_NoticeBoard_UserId",
                table: "NoticeBoard",
                column: "UserId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "NoticeBoard");

            migrationBuilder.DropTable(
                name: "Users");
        }
    }
}

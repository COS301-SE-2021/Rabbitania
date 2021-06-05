using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Migrations
{
    public partial class BeginningMigration : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "noticeBoard",
                columns: table => new
                {
                    NoticeBoardID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    noticeBoardThreadIDs = table.Column<List<int>>(type: "integer[]", nullable: true),
                    title = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_noticeBoard", x => x.NoticeBoardID);
                });

            migrationBuilder.CreateTable(
                name: "noticeBoardThreads",
                columns: table => new
                {
                    threadID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    ThreadTitle = table.Column<string>(type: "text", nullable: true),
                    ThreadContent = table.Column<string>(type: "text", nullable: true),
                    ThreadCreationDate = table.Column<string>(type: "text", nullable: true),
                    ThreadDueDate = table.Column<string>(type: "text", nullable: true),
                    UserID = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_noticeBoardThreads", x => x.threadID);
                });

            migrationBuilder.CreateTable(
                name: "notifications",
                columns: table => new
                {
                    notificationID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    notificationContent = table.Column<string>(type: "text", nullable: true),
                    notificationType = table.Column<int>(type: "integer", nullable: false),
                    dateCreated = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    UserID = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_notifications", x => x.notificationID);
                });

            migrationBuilder.CreateTable(
                name: "userEmails",
                columns: table => new
                {
                    userEmailsID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    userEmail = table.Column<string>(type: "text", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_userEmails", x => x.userEmailsID);
                });

            migrationBuilder.CreateTable(
                name: "users",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "integer", nullable: false)
                        .Annotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn),
                    firstname = table.Column<string>(type: "text", nullable: true),
                    lastname = table.Column<string>(type: "text", nullable: true),
                    phoneNumber = table.Column<string>(type: "text", nullable: true),
                    pinnedUserIDs = table.Column<List<int>>(type: "integer[]", nullable: true),
                    userImage = table.Column<string>(type: "text", nullable: true),
                    userDescription = table.Column<string>(type: "text", nullable: true),
                    isOnline = table.Column<bool>(type: "boolean", nullable: false),
                    isAdmin = table.Column<bool>(type: "boolean", nullable: false),
                    employeeLevel = table.Column<int>(type: "integer", nullable: false),
                    userRoles = table.Column<int>(type: "integer", nullable: false),
                    officeLocation = table.Column<int>(type: "integer", nullable: false),
                    UserEmails = table.Column<List<int>>(type: "integer[]", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_users", x => x.UserID);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "noticeBoard");

            migrationBuilder.DropTable(
                name: "noticeBoardThreads");

            migrationBuilder.DropTable(
                name: "notifications");

            migrationBuilder.DropTable(
                name: "userEmails");

            migrationBuilder.DropTable(
                name: "users");
        }
    }
}

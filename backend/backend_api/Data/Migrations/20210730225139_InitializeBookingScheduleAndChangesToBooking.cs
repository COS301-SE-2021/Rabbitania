using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Data.Migrations
{
    public partial class InitializeBookingScheduleAndChangesToBooking : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BookingSchedules",
                columns: table => new
                {
                    TimeSlot = table.Column<DateTime>(type: "timestamp without time zone", nullable: false),
                    Office = table.Column<int>(type: "integer", nullable: false),
                    Availability = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_BookingSchedules", x => new { x.Office, x.TimeSlot });
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "BookingSchedules");
        }
    }
}

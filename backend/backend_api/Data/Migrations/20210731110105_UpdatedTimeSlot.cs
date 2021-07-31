using Microsoft.EntityFrameworkCore.Migrations;

namespace backend_api.Data.Migrations
{
    public partial class UpdatedTimeSlot : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "BookingSchedules",
                columns: table => new
                {
                    TimeSlot = table.Column<string>(type: "text", nullable: false),
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

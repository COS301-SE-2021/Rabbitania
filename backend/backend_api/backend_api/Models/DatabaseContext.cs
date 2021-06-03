using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models
{
    public class DatabaseContext : DbContext, IDatabaseContext
    {
        private List<int> listOfMockIds;
        public DatabaseContext(DbContextOptions options) : base(options)
        {

        }

        public DatabaseContext()
        {
            listOfMockIds = new List<int>();
            listOfMockIds.Add(1);
            listOfMockIds.Add(4);
        }
        
        public DbSet<User> users { get; set; }
        public DbSet<Notification> notifications { get; set; }
        public DbSet<UserEmails> userEmails { get; set; }
        public DbSet<NoticeBoardThread> noticeBoardThreads { get; set; }
        
        public DbSet<NoticeBoard> noticeBoard { get; set; }
        
        // Creating Seed Mock Data for Users
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1112,
                        firstname = "Matthew",
                        lastname = "Harty",
                        phoneNumber = "0834855754",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image.png",
                        userDescription = "Hello there",
                        isOnline = true,
                        isAdmin = true,
                        employeeLevel = 4,
                        userRoles = (UserRoles) 0,
                        officeLocation = (OfficeLocation) 0,
                        UserEmailsID = 1
                    }
                );
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1113,
                        firstname = "Castello",
                        lastname = "Govender",
                        phoneNumber = "0861830383",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image2.png",
                        userDescription = "Hey there!",
                        isOnline = false,
                        isAdmin = true,
                        employeeLevel = 6,
                        userRoles = (UserRoles) 1,
                        officeLocation = (OfficeLocation) 0
                    }
                );
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1114,
                        firstname = "James",
                        lastname = "Hulett",
                        phoneNumber = "0794756432",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image3.png",
                        userDescription = "Love gaming",
                        isOnline = false,
                        isAdmin = false,
                        employeeLevel = 5,
                        userRoles = (UserRoles) 3,
                        officeLocation = (OfficeLocation) 0,
                        UserEmailsID = 3
                    }
                );
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1115,
                        firstname = "Dean",
                        lastname = "Nortje",
                        phoneNumber = "08374646378",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image4.png",
                        userDescription = "Keep moving forward - Standard Bank",
                        isOnline = true,
                        isAdmin = true,
                        employeeLevel = 3,
                        userRoles = (UserRoles) 5,
                        officeLocation = (OfficeLocation) 0,
                        UserEmailsID = 4
                    }
                );
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1116,
                        firstname = "Joe",
                        lastname = "Harraway",
                        phoneNumber = "0112345667",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image5.png",
                        userDescription = "Love coding",
                        isOnline = false,
                        isAdmin = true,
                        employeeLevel = 2,
                        userRoles = (UserRoles) 2,
                        officeLocation = (OfficeLocation) 0,
                        UserEmailsID = 5
                    }
                );
            modelBuilder.Entity<User>()
                .HasData(
                    new
                    {
                        UserID = 1117,
                        firstname = "DeVilliers",
                        lastname = "Meiring",
                        phoneNumber = "08611112567",
                        pinnedUserIDs = listOfMockIds,
                        userImage = "image1.png",
                        userDescription = "Fighting life",
                        isOnline = false,
                        isAdmin = false,
                        employeeLevel = 5,
                        userRoles = (UserRoles) 0,
                        officeLocation = (OfficeLocation) 0,
                        UserEmailsID = 6
                    }
                );
        }

        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
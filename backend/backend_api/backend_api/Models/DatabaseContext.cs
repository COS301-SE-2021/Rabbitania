using System.Collections.Generic;
using System.Threading.Tasks;
using backend_api.Models.Notifications;
using Microsoft.EntityFrameworkCore;

namespace backend_api.Models
{
    public class DatabaseContext : DbContext, IDatabaseContext
    {
        private readonly List<int> mockIDs;
        public DatabaseContext(DbContextOptions options) : base(options)
        {

        }

        public DatabaseContext()
        {
            this.mockIDs = new List<int>();
            this.mockIDs.Add(1);
            this.mockIDs.Add(2);
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
                   UserID = 1,
                   email = "mattharty@retrorabbit.co.za",
                   firstname = "Matthew",
                   lastname = "Harty",
                   phoneNumber = "0834855754",
                   pinnedUserIDs = this.mockIDs,
                   userImage = "image.png",
                   userDescription = "Hello there",
                   isOnline = true,
                   isAdmin = true,
                   employeeLevel = 4,
                   userRoles = (UserRoles) 0,
                   officeLocation = (OfficeLocation) 0
                }
            );
            modelBuilder.Entity<User>()
                .HasData(
                new
                {
                    UserID = 2,
                    email = "rorymcilroy@retrorabbit.co.za",
                    firstname = "Rory",
                    lastname = "McIlroy",
                    phoneNumber = "0113445667",
                    pinnedUserIDs = this.mockIDs,
                    userImage = "image1.png",
                    userDescription = "Love golf.",
                    isOnline = false,
                    isAdmin = false,
                    employeeLevel = 5,
                    userRoles = (UserRoles) 2,
                    officeLocation = (OfficeLocation) 0,
                }
            );
            modelBuilder.Entity<User>()
                .HasData(
                new
                {
                    UserID = 3,
                    email = "cgovender@retrorabbit.co.za",
                    firstname = "Castello",
                    lastname = "Govender",
                    phoneNumber = "0861830383",
                    pinnedUserIDs = this.mockIDs,
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
                    UserID = 4,
                    email = "jameshulett@retrorabbit.co.za",
                    firstname = "James",
                    lastname = "Hulett",
                    phoneNumber = "0794756432",
                    pinnedUserIDs = this.mockIDs,
                    userImage = "image3.png",
                    userDescription = "Love gaming",
                    isOnline = false,
                    isAdmin = false,
                    employeeLevel = 5,
                    userRoles = (UserRoles) 3,
                    officeLocation = (OfficeLocation) 0
                }
            );
            modelBuilder.Entity<User>()
                .HasData(
                new
                {
                    UserID = 5,
                    email = "deannortje@retrorabbit.co.za",
                    firstname = "Dean",
                    lastname = "Nortje",
                    phoneNumber = "08374646378",
                    pinnedUserIDs = this.mockIDs,
                    userImage = "image4.png",
                    userDescription = "Keep moving forward - Standard Bank",
                    isOnline = true,
                    isAdmin = true,
                    employeeLevel = 3,
                    userRoles = (UserRoles) 5,
                    officeLocation = (OfficeLocation) 0
                }
            );
            modelBuilder.Entity<User>()
                .HasData(
                new
                {
                    UserID = 6,
                    email = "josephharraway@retrorabbit.co.za",
                    firstname = "Joe",
                    lastname = "Harraway",
                    phoneNumber = "0112345667",
                    pinnedUserIDs = this.mockIDs,
                    userImage = "image5.png",
                    userDescription = "Love coding",
                    isOnline = false,
                    isAdmin = true,
                    employeeLevel = 2,
                    userRoles = (UserRoles) 2,
                    officeLocation = (OfficeLocation) 0
                }
            );
            modelBuilder.Entity<User>()
                .HasData(
                new
                {
                    UserID = 7,
                    email = "devilliersmeiring@retrorabbit.co.za",
                    firstname = "DeVilliers",
                    lastname = "Meiring",
                    phoneNumber = "08611112567",
                    pinnedUserIDs = this.mockIDs,
                    userImage = "image1.png",
                    userDescription = "Fighting life",
                    isOnline = false,
                    isAdmin = false,
                    employeeLevel = 5,
                    userRoles = (UserRoles) 0,
                    officeLocation = (OfficeLocation) 0
                }
            );
        }
        public async Task<int> SaveChanges()
        {
            return await base.SaveChangesAsync();
        }
    }
}
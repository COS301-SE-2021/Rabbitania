﻿// <auto-generated />
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using backend_api.Models;

namespace backend_api.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    partial class DatabaseContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 63)
                .HasAnnotation("ProductVersion", "6.0.0-preview.4.21253.1")
                .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            modelBuilder.Entity("backend_api.Models.NoticeBoardThread", b =>
                {
                    b.Property<int>("threadID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<int>("UserID")
                        .HasColumnType("integer");

                    b.Property<string>("threadContent")
                        .HasColumnType("text");

                    b.Property<string>("threadCreationDate")
                        .HasColumnType("text");

                    b.Property<string>("threadDueDate")
                        .HasColumnType("text");

                    b.Property<string>("threadTitle")
                        .HasColumnType("text");

                    b.HasKey("threadID");

                    b.ToTable("noticeBoardThreads");
                });

            modelBuilder.Entity("backend_api.Models.User", b =>
                {
                    b.Property<int>("UserID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<string>("email")
                        .HasColumnType("text");

                    b.Property<int>("employeeLevel")
                        .HasColumnType("integer");

                    b.Property<string>("firstname")
                        .HasColumnType("text");

                    b.Property<bool>("isAdmin")
                        .HasColumnType("boolean");

                    b.Property<bool>("isOnline")
                        .HasColumnType("boolean");

                    b.Property<string>("lastname")
                        .HasColumnType("text");

                    b.Property<int>("officeLocation")
                        .HasColumnType("integer");

                    b.Property<string>("phoneNumber")
                        .HasColumnType("text");

                    b.Property<List<int>>("pinnedUserIDs")
                        .HasColumnType("integer[]");

                    b.Property<string>("userDescription")
                        .HasColumnType("text");

                    b.Property<string>("userImage")
                        .HasColumnType("text");

                    b.Property<int>("userRoles")
                        .HasColumnType("integer");

                    b.HasKey("UserID");

                    b.ToTable("users");

                    b.HasData(
                        new
                        {
                            UserID = 1,
                            email = "mattharty@retrorabbit.co.za",
                            employeeLevel = 4,
                            firstname = "Matthew",
                            isAdmin = true,
                            isOnline = true,
                            lastname = "Harty",
                            officeLocation = 0,
                            phoneNumber = "0834855754",
                            userDescription = "Hello there",
                            userImage = "image.png",
                            userRoles = 0
                        },
                        new
                        {
                            UserID = 2,
                            email = "rorymcilroy@retrorabbit.co.za",
                            employeeLevel = 5,
                            firstname = "Rory",
                            isAdmin = false,
                            isOnline = false,
                            lastname = "McIlroy",
                            officeLocation = 0,
                            phoneNumber = "0113445667",
                            userDescription = "Love golf.",
                            userImage = "image1.png",
                            userRoles = 2
                        },
                        new
                        {
                            UserID = 3,
                            email = "cgovender@retrorabbit.co.za",
                            employeeLevel = 6,
                            firstname = "Castello",
                            isAdmin = true,
                            isOnline = false,
                            lastname = "Govender",
                            officeLocation = 0,
                            phoneNumber = "0861830383",
                            userDescription = "Hey there!",
                            userImage = "image2.png",
                            userRoles = 1
                        },
                        new
                        {
                            UserID = 4,
                            email = "jameshulett@retrorabbit.co.za",
                            employeeLevel = 5,
                            firstname = "James",
                            isAdmin = false,
                            isOnline = false,
                            lastname = "Hulett",
                            officeLocation = 0,
                            phoneNumber = "0794756432",
                            userDescription = "Love gaming",
                            userImage = "image3.png",
                            userRoles = 3
                        },
                        new
                        {
                            UserID = 5,
                            email = "deannortje@retrorabbit.co.za",
                            employeeLevel = 3,
                            firstname = "Dean",
                            isAdmin = true,
                            isOnline = true,
                            lastname = "Nortje",
                            officeLocation = 0,
                            phoneNumber = "08374646378",
                            userDescription = "Keep moving forward - Standard Bank",
                            userImage = "image4.png",
                            userRoles = 5
                        },
                        new
                        {
                            UserID = 6,
                            email = "josephharraway@retrorabbit.co.za",
                            employeeLevel = 2,
                            firstname = "Joe",
                            isAdmin = true,
                            isOnline = false,
                            lastname = "Harraway",
                            officeLocation = 0,
                            phoneNumber = "0112345667",
                            userDescription = "Love coding",
                            userImage = "image5.png",
                            userRoles = 2
                        },
                        new
                        {
                            UserID = 7,
                            email = "devilliersmeiring@retrorabbit.co.za",
                            employeeLevel = 5,
                            firstname = "DeVilliers",
                            isAdmin = false,
                            isOnline = false,
                            lastname = "Meiring",
                            officeLocation = 0,
                            phoneNumber = "08611112567",
                            userDescription = "Fighting life",
                            userImage = "image1.png",
                            userRoles = 0
                        });
                });
#pragma warning restore 612, 618
        }
    }
}

﻿// <auto-generated />
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using backend_api.Models;

namespace backend_api.Migrations
{
    [DbContext(typeof(DatabaseContext))]
    [Migration("20210603134717_AddedUserIDToUserEmails")]
    partial class AddedUserIDToUserEmails
    {
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 63)
                .HasAnnotation("ProductVersion", "6.0.0-preview.4.21253.1")
                .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

            modelBuilder.Entity("backend_api.Models.NoticeBoard", b =>
                {
                    b.Property<int>("NoticeBoardID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<List<int>>("noticeBoardThreadIDs")
                        .HasColumnType("integer[]");

                    b.Property<string>("title")
                        .HasColumnType("text");

                    b.HasKey("NoticeBoardID");

                    b.ToTable("noticeBoard");
                });

            modelBuilder.Entity("backend_api.Models.NoticeBoardThread", b =>
                {
                    b.Property<int>("threadID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<string>("ThreadContent")
                        .HasColumnType("text");

                    b.Property<string>("ThreadCreationDate")
                        .HasColumnType("text");

                    b.Property<string>("ThreadDueDate")
                        .HasColumnType("text");

                    b.Property<string>("ThreadTitle")
                        .HasColumnType("text");

                    b.Property<int>("UserID")
                        .HasColumnType("integer");

                    b.HasKey("threadID");

                    b.ToTable("noticeBoardThreads");
                });

            modelBuilder.Entity("backend_api.Models.Notifications.Notification", b =>
                {
                    b.Property<int>("notificationID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<int>("UserID")
                        .HasColumnType("integer");

                    b.Property<DateTime>("dateCreated")
                        .HasColumnType("timestamp without time zone");

                    b.Property<string>("notificationContent")
                        .HasColumnType("text");

                    b.Property<int>("notificationType")
                        .HasColumnType("integer");

                    b.HasKey("notificationID");

                    b.ToTable("notifications");
                });

            modelBuilder.Entity("backend_api.Models.User", b =>
                {
                    b.Property<int>("UserID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

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
                });

            modelBuilder.Entity("backend_api.Models.UserEmails", b =>
                {
                    b.Property<int>("userEmailID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("integer")
                        .HasAnnotation("Npgsql:ValueGenerationStrategy", NpgsqlValueGenerationStrategy.IdentityByDefaultColumn);

                    b.Property<int>("UserID")
                        .HasColumnType("integer");

                    b.Property<string>("userEmail")
                        .HasColumnType("text");

                    b.HasKey("userEmailID");

                    b.ToTable("userEmails");
                });
#pragma warning restore 612, 618
        }
    }
}

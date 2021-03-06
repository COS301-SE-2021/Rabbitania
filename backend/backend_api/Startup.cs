using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text.Json;
using System.Threading.Tasks;
using backend_api.Data.Booking;
using backend_api.Data.Enumerations;
using backend_api.Data.Forum;
using backend_api.Data.Node;
using backend_api.Data.NoticeBoard;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Models.Notification;
using backend_api.Models.Notification.Requests;
using backend_api.Models.User;
using backend_api.Services.Auth;
using backend_api.Services.Booking;
using backend_api.Services.Chat;
using backend_api.Services.Enumerations;
using backend_api.Services.Forum;
using backend_api.Services.Node;
using backend_api.Services.NoticeBoard;
using backend_api.Services.Notification;
using backend_api.Services.User;
using Hangfire;
using Hangfire.PostgreSql;
using FirebaseAdmin;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using Newtonsoft.Json.Linq;
using Npgsql;
using Npgsql.EntityFrameworkCore.PostgreSQL;

namespace backend_api
{
    public class Startup
    {
        readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
        private string _conn = null;
        public IConfiguration Configuration { get; }
       
        
        public Startup(IConfiguration configuration)
        {
           Configuration = configuration;
           StaticConfig = configuration;
        }

        public static IConfiguration StaticConfig { get; private set; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            //FirebaseApp.Create();
            
            services.AddCors(options =>
            {
                options.AddPolicy(name: MyAllowSpecificOrigins,
                    builder =>
                    {
                        builder.AllowAnyOrigin();
                        builder.AllowAnyMethod();
                        builder.AllowAnyHeader();
                    });
            });
            services.AddTransient<IAuthService, AuthService>();
            

             services.AddHangfire(options =>
             {
                 options.UsePostgreSqlStorage(Environment.GetEnvironmentVariable("MAIN_CONN_STRING"));
                 
             });
            services.AddResponseCaching();
            services.AddControllers();
            /*
            Line #3 defined the name of the context class to be added. In our cases it is DatabaseContext.
            Line #4 states that we are using Npgsql as ourPostgres Database Provider.
            Line #5 mentions the Connection string name that we have already defined in appsettings.json.
            Line #6 Binds the Concrete Class and the Interface into our Application Container.
            */

            services.Configure<EmailSettings>(Configuration.GetSection("EmailSettings"));
            //----------------------------------------------------------------------------------------------------------------------
            // Enumeration DB Context
            services.AddDbContext<EnumContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(EnumContext).Assembly.FullName)));

            services.AddScoped<IEnumContext>(provider => provider.GetService<EnumContext>());
            
            services.AddScoped<IEnumRepository, EnumRepository>();
            services.AddScoped<IEnumService, EnumService>();
            //----------------------------------------------------------------------------------------------------------------------
            //----------------------------------------------------------------------------------------------------------------------
            // Booking DB Context
            services.AddDbContext<BookingContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(BookingContext).Assembly.FullName)));

            services.AddScoped<IBookingContext>(provider => provider.GetService<BookingContext>());
            
            services.AddScoped<IBookingRepository, BookingRepository>();
            services.AddScoped<IBookingService, BookingService>();
            //----------------------------------------------------------------------------------------------------------------------
            //BookingSchedule DB Context
            
            services.AddDbContext<BookingScheduleContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(BookingScheduleContext).Assembly.FullName)));

            services.AddScoped<IBookingScheduleContext>(provider => provider.GetService<BookingScheduleContext>());
            
            services.AddScoped<IBookingScheduleRepository, BookingScheduleRepository>();
            services.AddScoped<IBookingScheduleService, BookingScheduleService>();
            //---------
            //----------------------------------------------------------------------------------------------------------------------
            // Notification DB Context
            services.AddDbContext<NotificationContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(NotificationContext).Assembly.FullName)));

            services.AddScoped<INotificationContext>(provider => provider.GetService<NotificationContext>());

            services.AddScoped<INotificationRepository, NotificationRepository>();
            services.AddScoped<INotificationService, NotificationService>();
            //----------------------------------------------------------------------------------------------------------------------
            
            //----------------------------------------------------------------------------------------------------------------------
            //NoticeBoard DB Context
            services.AddDbContext<NoticeBoardContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(NoticeBoardContext).Assembly.FullName)));

            services.AddScoped<INoticeBoardContext>(provider => provider.GetService<NoticeBoardContext>());

            services.AddScoped<INoticeBoardRepository, NoticeBoardRepository>();
            services.AddScoped<INoticeBoardService, NoticeBoardService>();
            //----------------------------------------------------------------------------------------------------------------------
            
            //----------------------------------------------------------------------------------------------------------------------
            //User DB Context
            services.AddDbContext<UserContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(UserContext).Assembly.FullName)));

            services.AddScoped<IUserContext>(provider => provider.GetService<UserContext>());
            
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IUserService, UserService>();
            services.AddScoped<IAuthService, AuthService>();
            //----------------------------------------------------------------------------------------------------------------------
            
            //----------------------------------------------------------------------------------------------------------------------
            //Forum DB Context
            
            services.AddDbContext<ForumContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(ForumContext).Assembly.FullName)));

            services.AddScoped<IForumContext>(provider => provider.GetService<ForumContext>());
            
            services.AddScoped<IForumRepository, ForumRepository>();
            services.AddScoped<IForumService, ForumService>();
            //----------------------------------------------------------------------------------------------------------------------
            //Node DB Context
            
            services.AddDbContext<NodeContext>(options =>
                options.UseNpgsql(
                    Environment.GetEnvironmentVariable("MAIN_CONN_STRING") ?? string.Empty,
                    b => b.MigrationsAssembly(typeof(NodeContext).Assembly.FullName)));

            services.AddScoped<INodeContext>(provider => provider.GetService<NodeContext>());
            
            services.AddScoped<INodeRepository, NodeRepository>();
            services.AddScoped<INodeService, NodeService>();
            //----------------------------------------------------------------------------------------------------------------------
            //Chat service
            
            services.AddScoped<IChatService, ChatService>();
            //----------------------------------------------------------------------------------------------------------------------
            
            services.AddControllers();

            #region Swagger

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo {Title = "Rabbitania API Gateway", Version = "v2"});
            });

            #endregion
            
            services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme).AddJwtBearer(options =>
            {
                options.Authority = "https://securetoken.google.com/" +
                                    Environment.GetEnvironmentVariable("GOOGLE_CLOUD_PROJECT").ToString();
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidIssuer = "https://securetoken.google.com/" +
                                  Environment.GetEnvironmentVariable("GOOGLE_CLOUD_PROJECT").ToString(),
                    ValidateAudience = true,
                    ValidAudience = Environment.GetEnvironmentVariable("GOOGLE_CLOUD_PROJECT").ToString(),
                    ValidateLifetime = true
                };
            });
            services.AddAuthorization();

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            var options = new BackgroundJobServerOptions()
            {
                WorkerCount = 1
            };
            
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage();
                #region Swagger
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "backend_api v1"));
            }
            #endregion
            app.UseHttpsRedirection();
            
            app.UseRouting();
            app.UseCors(MyAllowSpecificOrigins);
            app.UseAuthentication();
            app.UseAuthorization();

            app.UseHangfireDashboard();
            app.UseHangfireServer(options);
            
            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
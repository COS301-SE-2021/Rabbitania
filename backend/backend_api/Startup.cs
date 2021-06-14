using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using backend_api.Data.NoticeBoard;
using backend_api.Data.Notification;
using backend_api.Data.User;
using backend_api.Models.User;
using backend_api.Services.NoticeBoard;
using backend_api.Services.Notification;
using backend_api.Services.User;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.HttpsPolicy;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi.Models;
using Npgsql;
using Npgsql.EntityFrameworkCore.PostgreSQL;

namespace backend_api
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            /*
            Line #3 defined the name of the context class to be added. In our cases it is DatabaseContext.
            Line #4 states that we are using Npgsql as ourPostgres Database Provider.
            Line #5 mentions the Connection string name that we have already defined in appsettings.json.
            Line #6 Binds the Concrete Class and the Interface into our Application Container.
            */

            services.AddAuthentication(option =>
            {
                option.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
            }).AddCookie(options => { options.LoginPath = "/api/googleSignIn"; }).AddGoogle(options =>
            {
                options.ClientId = "833458984650-lgvrm8l1tr0pns2h5iqo8pdtlsmjlrj0.apps.googleusercontent.com";
                options.ClientSecret = "kRAj8pP1eUEzRaOosZ6JShGJ";
            });

            // Notification DB Context
            // Notification Configuration
            services.AddDbContext<NotificationContext>(options =>
                options.UseNpgsql(
                    Configuration.GetConnectionString("RabbitaniaDatabase"),
                    b => b.MigrationsAssembly(typeof(NotificationContext).Assembly.FullName)));

            services.AddScoped<INotificationContext>(provider => provider.GetService<NotificationContext>());

            services.AddScoped<INotificationRepository, NotificationRepository>();
            services.AddScoped<INotificationService, NotificationService>();
            //
        //NoticeBoard DB Context
            services.AddDbContext<NoticeBoardContext>(options =>
                options.UseNpgsql(
                    Configuration.GetConnectionString("RabbitaniaDatabase"),
                    b => b.MigrationsAssembly(typeof(NoticeBoardContext).Assembly.FullName)));

            services.AddScoped<INoticeBoardContext>(provider => provider.GetService<NoticeBoardContext>());

            services.AddScoped<INoticeBoardRepository, NoticeBoardRepository>();
            services.AddScoped<INoticeBoardService, NoticeBoardService>();
            //User DB Context
            services.AddDbContext<UserContext>(options =>
                options.UseNpgsql(
                    Configuration.GetConnectionString("RabbitaniaDatabase"),
                    b => b.MigrationsAssembly(typeof(UserContext).Assembly.FullName)));

            services.AddScoped<IUserContext>(provider => provider.GetService<UserContext>());
            
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<IUserService, UserService>();
            //----------------------------------------------------------------------------------------------------------------------

            services.AddControllers();

            #region Swagger

            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo {Title = "Rabbitania API Gateway", Version = "v1"});
            });

            #endregion

            services.AddAuthorization();

            //Npgsql connection for Postresql

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
          

    if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                #region Swagger
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "backend_api v1"));
            }
            #endregion
            app.UseHttpsRedirection();

            app.UseRouting();
            app.UseAuthentication();
            app.UseAuthorization();
            
            app.UseEndpoints(endpoints => { endpoints.MapControllers(); });
        }
    }
}
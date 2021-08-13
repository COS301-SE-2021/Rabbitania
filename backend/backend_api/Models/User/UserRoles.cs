using Microsoft.AspNetCore.Identity;

namespace backend_api.Models.User
{
    public enum UserRoles
    {
        Developer,
        Designer,
        Administrator,
        CareTaker,
        ScrumMaster,
        CAM,
        Director,
        Graduate,
        Intern,
        Unassigned
    }
}
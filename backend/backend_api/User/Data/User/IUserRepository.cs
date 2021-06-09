using System.Threading.Tasks;
using backend_api.User.Models;

namespace backend_api.User.Data.User
{
    public interface IUserRepository
    {
        Task<Models.User.User[]> RetrieveUsers(int userID);
    }
}
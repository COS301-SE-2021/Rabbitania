namespace backend_api.Models
{
    public class UserRepository : IUserRepository
    {
        private readonly DatabaseContext _dbContext;
        
        public UserRepository(DatabaseContext DbContext)
        {
            this._dbContext = DbContext;
        } 
    }
}
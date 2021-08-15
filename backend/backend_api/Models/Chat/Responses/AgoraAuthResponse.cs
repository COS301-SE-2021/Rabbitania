namespace backend_api.Models.Chat.Responses
{
    public class AgoraAuthResponse
    {
        
        public string channel { get; set; }

        public dynamic uid { get; set; }

        public string token { get; set; }

        public AgoraAuthResponse(string channel, dynamic uid, string token)
        {
            this.channel = channel;
            this.uid = uid;
            this.token = token;
        }
    }
}
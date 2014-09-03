using Microsoft.AspNet.Builder;

namespace DotNETvNextCITravis
{
    public class Startup
    {
        public void Configure(IBuilder app)
        {
            app.UseStaticFiles();
	    app.UseWelcomePage();
	}
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DiscInventory
{
    public partial class borrower : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Check for if page is valid and if so, update lblMessage to inform user data was input correctly
            if (IsValid)
            {
                lblMessage.Text = "Thank you for joining our program!<br/> We'll contact you again soon!";

                

                

            }
        }
        

        protected void btnClear_Click(object sender, EventArgs e)
        {
            
        }

        protected void dvBorrower_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        {
            // Check for if page is valid and if so, update lblMessage to inform user data was input correctly
            if (IsValid)
            {
                lblMessage.Text = "Thank you for joining our program!<br/> We'll contact you again soon!";





            }
        }
    }
}
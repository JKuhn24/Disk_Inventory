<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DiscInventory.Login" %>


<%-- 

Original Author: Jeffrey Kuhn
Date Created: 5/11/20
Version: 1
Date Last Modified: 5/11/20
Modified by: Jeffrey Kuhn
Modification log: Page created

    5/11/2020: page created to allow for authenicating users
 
--%>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
         <h4 style="font-size: medium">Log In</h4>
         <hr />
         <asp:PlaceHolder runat="server" ID="LoginStatus" Visible="false">
            <p>
               <asp:Literal runat="server" ID="StatusText" />
            </p>
         </asp:PlaceHolder>
         <asp:PlaceHolder runat="server" ID="LoginForm" Visible="false">
            <div style="margin-bottom: 10px">
               <asp:Label runat="server" AssociatedControlID="UserName">User name</asp:Label>
                  <asp:TextBox runat="server" ID="UserName" />
               </div>
            <div style="margin-bottom: 10px">
               <asp:Label runat="server" AssociatedControlID="Password">Password</asp:Label>
                  <asp:TextBox runat="server" ID="Password" TextMode="Password" />
               </div>
            <div style="margin-bottom: 10px">
                  <asp:Button runat="server" OnClick="SignIn" Text="Log in" />
               </div>
             <div>
                 <a href="Register.aspx">New? Create a new user by clicking here!</a>
             </div>
         </asp:PlaceHolder>
         <asp:PlaceHolder runat="server" ID="LogoutButton" Visible="false">
            <div>
               <div>
                  <asp:Button runat="server" OnClick="SignOut" Text="Log out" />
               </div>
            </div>
         </asp:PlaceHolder>
      </div>
</asp:Content>

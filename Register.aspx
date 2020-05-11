<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="DiscInventory.Register" %>



<%-- 

Original Author: Jeffrey Kuhn
Date Created: 5/11/20
Version: 1
Date Last Modified: 5/11/20
Modified by: Jeffrey Kuhn
Modification log: Page created

    5/11/2020: page created to allow for creating new users
 
--%>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
    <h4 style="font-size: medium">Register a new user</h4>
        <hr />
               
        <div style="margin-bottom:10px">
            <div>
            <asp:Label runat="server" AssociatedControlID="UserName">User name</asp:Label>
                <asp:TextBox runat="server" ID="UserName" />       
            </div>
            <div>
            <asp:Label runat="server" AssociatedControlID="Password">Password</asp:Label>
                <asp:TextBox runat="server" ID="Password" TextMode="Password" />    
            </div>
            <div>
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword">Confirm password</asp:Label>
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" />    
            </div>
            <div>
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" />
            </div>
        </div>
                <p>
            <asp:Literal runat="server" ID="StatusMessage" />
        </p> 
    </div>
</asp:Content>

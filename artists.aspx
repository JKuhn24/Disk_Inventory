<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DiscInventory.artists"  
    MasterPageFile="~/Site1.Master" ClientIDMode="Static"%>
<%-- 

Original Author: Jeffrey Kuhn
Date Created: 4/24/20
Version: 1
Date Last Modified: 5/1/20
Modified by: Jeffrey Kuhn
Modification log: Page created

    5/1/2020: Added Grid View, Details View and the ability to update, delete and insert data in the database
 
--%>
            <%-- Content tag to replace info on the Site1.Master file --%>
            <asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
                 <div class="tables">
                     <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="edit"/>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" DataKeyNames="Artist_ID">
                    <Columns>
                        <asp:BoundField DataField="Artist_ID" HeaderText="Artist_ID" SortExpression="Artist_ID" InsertVisible="False" ReadOnly="True" />
                        <asp:TemplateField HeaderText="Artist_Name" SortExpression="Artist_Name">
                            <EditItemTemplate>
                                <%--enter the artist name and validates--%>
                                <asp:TextBox ID="txtNameE" runat="server" Text='<%# Bind("Artist_Name") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required." 
                                    ValidationGroup="edit" ControlToValidate="txtNameE">*</asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Artist_Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Artist_Type_ID" SortExpression="Artist_Type_ID">
                            <EditItemTemplate>
                                <%--enter the Artist Type ID and then validates--%>
                                <asp:TextBox ID="txtTypeIDE" runat="server" Text='<%# Bind("Artist_Type_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Type ID is required."
                                    ValidationGroup="edit" ControlToValidate="txtTypeIDE" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="ID number must be either 1 or 2." ValidationGroup="edit" Type="Integer" 
                                    MaximumValue="2" MinimumValue="1" ControlToValidate="txtTypeIDE"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Artist_Type_ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:CommandField ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView> 
                     <%--data source to delete, update or insert data using stored procedures--%>
                     <asp:SqlDataSource ID="SqlDataSource2" runat="server"
                         ConnectionString="<%$ ConnectionStrings:DiskInventoryConnection %>" DeleteCommand="sp_delete_artist" 
                         InsertCommand="sp_insert_artist" 
                         SelectCommand="SELECT [Artist_ID], [Artist_Name], [Artist_Type_ID] FROM [Artist] ORDER BY [Artist_Name]" 
                         UpdateCommand="sp_update_artist" DeleteCommandType="StoredProcedure" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                         <DeleteParameters>
                             <asp:Parameter Name="Artist_ID" Type="Int32" />
                         </DeleteParameters>
                         <InsertParameters>
                             <asp:Parameter Name="Artist_Name" Type="String" />
                             <asp:Parameter Name="Artist_Type_ID" Type="Int32" />
                         </InsertParameters>
                         <UpdateParameters>
                             <asp:Parameter Name="Artist_ID" Type="Int32" />
                             <asp:Parameter Name="Artist_Name" Type="String" />
                             <asp:Parameter Name="Artist_Type_ID" Type="Int32" />
                         </UpdateParameters>
                     </asp:SqlDataSource>
                </div>


                 <h1>Add more Artists?</h1>
                <p>Want to add more Artists? Add them here!</p>
                <div class="tables2">
                    <%--form to insert data into artist table--%>
                    <asp:DetailsView ID="dvArtist" runat="server"
                    AutoGenerateRows="False" DataKeyNames="Artist_ID" DataSourceID="SqlDataSource2" DefaultMode="Insert">
                    <Fields>
                        <asp:TemplateField HeaderText="Artist_Name" SortExpression="Artist_Name">
                            <InsertItemTemplate>
                                <%--enter artist name and validates--%>
                                <asp:TextBox runat="server" Text='<%# Bind("Artist_Name") %>' ID="txtName"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required." 
                                    ValidationGroup="Insert" ControlToValidate="txtName">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Artist_ID" HeaderText="Artist_ID" InsertVisible="False" ReadOnly="True" SortExpression="Artist_ID" />
                        <asp:TemplateField HeaderText="Artist_Type_ID" SortExpression="Artist_Type_ID">
                            <InsertItemTemplate>
                                <%--enter artist type id and validates--%>
                                <asp:TextBox ID="txtTypeID" runat="server" Text='<%# Bind("Artist_Type_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Type ID is required."
                                    ValidationGroup="Insert" ControlToValidate="txtTypeID" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="ID number must be either 1 or 2." ValidationGroup="Insert" Type="Integer" 
                                    MaximumValue="2" MinimumValue="1" ControlToValidate="txtTypeID"></asp:RangeValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowInsertButton="True" ValidationGroup="Insert"/>
                    </Fields>
                </asp:DetailsView>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    HeaderText="Please correct the following errors:" 
                    ValidationGroup="Insert" />

                    <!-- Label to be updated upon form being correctly validated -->
                <asp:label ID="lblmsg" runat="server"></asp:label>
                </div>
            </asp:Content>
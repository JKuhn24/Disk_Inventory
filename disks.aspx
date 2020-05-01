<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="DiscInventory.disks"  
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
                <div class="CD">
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="edit"/>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource3" DataKeyNames="CD_ID">
                    <Columns>
                        <asp:BoundField DataField="CD_ID" HeaderText="CD_ID" SortExpression="CD_ID" InsertVisible="False" ReadOnly="True" />
                        <asp:TemplateField HeaderText="CD_name" SortExpression="CD_name">
                            <EditItemTemplate>
                                <%--enter CD name and validates--%>
                                <asp:TextBox ID="txtNameE" runat="server" Text='<%# Bind("CD_name") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required." 
                                    ValidationGroup="edit" ControlToValidate="txtNameE">*</asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("CD_name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release_Date" SortExpression="Release_Date">
                            <EditItemTemplate>
                                <%--enter release data and validate--%>
                                <asp:TextBox ID="txtDateE" runat="server" Text='<%# Bind("Release_Date") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Date requried" 
                                    ControlToValidate="txtDateE" EnableTheming="True" ValidationGroup="edit" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Must ba a date" 
                                    ControlToValidate="txtDateE" Type="Date" Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="edit"></asp:CompareValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("Release_Date") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type_ID" SortExpression="Type_ID">
                            <EditItemTemplate>
                                <%--enter the type id of the cd and validates--%>
                                <asp:TextBox ID="txtTypeIDE" runat="server" Text='<%# Bind("Type_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Type ID is required."
                                    ValidationGroup="edit" ControlToValidate="txtTypeIDE" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="ID number must be either 1 or 5." ValidationGroup="edit" Type="Integer" 
                                    MaximumValue="5" MinimumValue="1" ControlToValidate="txtTypeIDE"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("Type_ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status_ID" SortExpression="Status_ID">
                            <EditItemTemplate>
                                <%--enter the status ID of the cd and validate--%>
                                <asp:TextBox ID="txtStatusIDE" runat="server" Text='<%# Bind("Status_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Status ID is required." 
                                    ControlToValidate="txtStatusIDE" ValidationGroup="edit" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Must be between 1 and 4." 
                                    ControlToValidate="txtStatusIDE" MaximumValue="4" MinimumValue="1" ValidationGroup="edit" Display="Dynamic"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("Status_ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Genre_ID" SortExpression="Genre_ID">
                            <EditItemTemplate>
                                <%--enter the genre id and validates--%>
                                <asp:TextBox ID="txtGenreIDE" runat="server" Text='<%# Bind("Genre_ID") %>'></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Status ID is required." 
                                    ControlToValidate="txtGenreIDE" ValidationGroup="edit" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Must be between 1 and 5." 
                                    ControlToValidate="txtGenreIDE" MaximumValue="5" MinimumValue="1" ValidationGroup="edit" Display="Dynamic"></asp:RangeValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("Genre_ID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    </Columns>
                </asp:GridView> 
                    <%--data source to delete, update and insert data using stored procedures--%>
                     <asp:SqlDataSource ID="SqlDataSource3" runat="server"
                         ConnectionString="<%$ ConnectionStrings:DiskInventoryConnection %>" InsertCommand="sp_insert_CD" 
                         SelectCommand="SELECT [CD_ID], [CD_name], [Release_Date], [Type_ID], [Status_ID], [Genre_ID] FROM [CD] ORDER BY [CD_name]" 
                         UpdateCommand="sp_update_CD" DeleteCommandType="StoredProcedure" DeleteCommand="sp_delete_CD" InsertCommandType="StoredProcedure" UpdateCommandType="StoredProcedure">
                         <DeleteParameters>
                             <asp:Parameter Name="CD_ID" Type="Int32" />
                         </DeleteParameters>
                         <InsertParameters>
                             <asp:Parameter Name="CD_name" Type="String" />
                             <asp:Parameter DbType="Date" Name="Release_Date" />
                             <asp:Parameter Name="Type_ID" Type="Int32" />
                             <asp:Parameter Name="Status_ID" Type="Int32" />
                             <asp:Parameter Name="Genre_ID" Type="Int32" />
                         </InsertParameters>
                         <UpdateParameters>
                             <asp:Parameter Name="CD_ID" Type="Int32" />
                             <asp:Parameter Name="CD_name" Type="String" />
                             <asp:Parameter DbType="Date" Name="Release_Date" />
                             <asp:Parameter Name="Type_ID" Type="Int32" />
                             <asp:Parameter Name="Status_ID" Type="Int32" />
                             <asp:Parameter Name="Genre_ID" Type="Int32" />
                         </UpdateParameters>
                    </asp:SqlDataSource>
                </div>


                 <h1>Add more CDs?</h1>
                <p>Want to add more CDs? Add them here!</p>
                <div class="tables2">
                    <asp:DetailsView ID="dvCD" runat="server"
                    AutoGenerateRows="False" DataKeyNames="CD_ID" DataSourceID="SqlDataSource3" DefaultMode="Insert">
                    <Fields>
                        <asp:TemplateField HeaderText="CD_name" SortExpression="CD_name">
                            <InsertItemTemplate>
                                <%--enter cd name and validates--%>
                                <asp:TextBox ID="txtName" runat="server" Text='<%# Bind("CD_name") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name is required." 
                                    ValidationGroup="Insert" ControlToValidate="txtName">*</asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Release_Date" SortExpression="Release_Date">
                            <InsertItemTemplate>
                                <%--enter release date and validates--%>
                                <asp:TextBox ID="txtDate" runat="server" Text='<%# Bind("Release_Date") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Date requried" 
                                    ControlToValidate="txtDate" EnableTheming="True" ValidationGroup="Insert" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Must ba a date" ControlToValidate="txtDate" Type="Date" Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="Insert"></asp:CompareValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Type_ID" SortExpression="Type_ID">
                            <InsertItemTemplate>
                                <%--enter type id and validates--%>
                                <asp:TextBox ID="txtTypeID" runat="server" Text='<%# Bind("Type_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Type ID is required."
                                    ValidationGroup="Insert" ControlToValidate="txtTypeID" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="ID number must be either 1 or 5." ValidationGroup="Insert" Type="Integer" 
                                    MaximumValue="5" MinimumValue="1" ControlToValidate="txtTypeID"></asp:RangeValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status_ID" SortExpression="Status_ID">
                            <InsertItemTemplate>
                                <%--enter the status id and validates--%>
                                <asp:TextBox ID="txtStatusID" runat="server" Text='<%# Bind("Status_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Status ID is required." 
                                    ControlToValidate="txtStatusID" ValidationGroup="Insert" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Must be between 1 and 4." 
                                    ControlToValidate="txtStatusID" MaximumValue="4" MinimumValue="1" ValidationGroup="Insert" Display="Dynamic"></asp:RangeValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Genre_ID" SortExpression="Genre_ID">
                            <InsertItemTemplate>
                                <%--enter the genre id and validates--%>
                                <asp:TextBox ID="txtGenreID" runat="server" Text='<%# Bind("Genre_ID") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Status ID is required." 
                                    ControlToValidate="txtGenreID" ValidationGroup="Insert" Display="Dynamic">*</asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Must be between 1 and 5." 
                                    ControlToValidate="txtGenreID" MaximumValue="5" MinimumValue="1" ValidationGroup="Insert" Display="Dynamic"></asp:RangeValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                       <asp:CommandField ShowInsertButton="True" ValidationGroup="Insert"/>
                    </Fields>
                </asp:DetailsView>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    HeaderText="Please correct the following errors:" 
                    ValidationGroup="Insert" />

                </div>
            </asp:Content>
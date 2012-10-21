#require 'ironfist_client'
class CloudIdentitiesController < ApplicationController
  def index
  end

  def new

#@ironclient = Ironclient.new
ir = IronfistClient.new
tempparms = {:agent => "CloudIdentityAgent", :command => "listRealms", :message => "URL=http://nomansland.com REALM_NAME=temporealm"}
ir.pub_and_wait(Ironfist::Init.instance.connection, tempparms,0) do |resp|
puts "result #{resp}"
end

    current_user.organization.build_cloud_identity
  end

  def create
    @cloud_identity = current_user.organization.build_cloud_identity(params[:cloud_identity]) || CloudIdentity.new(params[:cloud_identity])

    if @cloud_identity.save
      flash[:success] = "Cloud Identity Created with #{current_user.organization.account_name}"
      #redirect_to customizations_show_url
   
 respond_to do |format|
      format.html { redirect_to customizations_show_url }
      format.js
    end
   end
  end

  def show
    @user = User.find(params[:id])
    if !@user.organization
      flash[:error] = "Please Create Organization Details first"
      redirect_to edit_user_path(current_user)
    end
  end

  def update
    @cloud_identity=CloudIdentity.find(params[:id])
    if @cloud_identity.update_attributes(params[:cloud_identity])
      flash[:success] = "Cloud_identity #{current_user.organization.account_name} updated"
      redirect_to customizations_show_url
    end
  end

  def destroy

    CloudIdentity.find(params[:id]).destroy
    flash[:success] = "Cloud_identity #{current_user.organization.account_name} destroyed."
    redirect_to customizations_show_url
  end
end

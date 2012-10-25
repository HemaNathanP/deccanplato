package org.megam.deccanplato.provider.dropbox;

import java.util.Map;

import org.megam.deccanplato.provider.AbstractProviderAdapter;
import org.megam.deccanplato.provider.BusinessActivity;

public class DropboxAdapter extends AbstractProviderAdapter {

	private BusinessActivity activity;

	public DropboxAdapter(Map<String, String> tempArgs) {
		super(tempArgs);
	}

	public void configure() {
		/* using the user#create key */
		//activity = registry.getBusinessActivity(cloud_app, business_function);
	}

	public boolean build() {
		/** get the handle responsible for the call and stick stuff into it **/
		activity.setArguments(args);
		return true;
	}
	
	public Map<String,String> handle() {
		return activity.run();
	}
	 
}

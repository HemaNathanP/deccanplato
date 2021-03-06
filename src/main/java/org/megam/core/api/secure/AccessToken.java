/* “Copyright 2012 Megam Systems”
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package org.megam.core.api.secure;

public class AccessToken {
	
	private String token;
	private String email;
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String tempEmail) {
		this.email  = tempEmail;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token  = token;
	}

}

# Openpub plugin.
Met de Openpub-plugin voor WordPress, breidt je WordPress uit voor het beheren en publiceren van nieuwsberichten en werkinstructies (PUB-publicaties) voor de KISS frontend.

## Local development configuration

Once you have installed WordPress and have it running within your cluster, you can configure the Wordpress installation:

1. Navigate to `localhost/wp-admin`, initiate Wordpress and login


## Setting up the plugin

_Note: to start this step, you're expected to have an active WordPress installation running. See also the chapter on installation._

1. Activate the plugins: OpenPub and Advanced Custom Fields
2. Navigate to "Aangepaste velden" and then to "Gereedschap"
3. Upload the file `plugins/OpenPub/publication-acf-group.json` within the "Veldgroepen Importeren" option
4. Create one (or multiple) new users with the role "KISS Redacteur"  
   _Note: users with the assigned role "KISS Redacteur" can now create and maintain publications._
5. Navigate to "OpenPub" > "Configuration" and add the gateway URI to the "API Domain" field. Add the gateway API key to the "API KEY" field.

### Managing users

_Note: Users with the user role "Administrator" can create new users, an account with this role is automatically assigned once WordPress is installed. **For this portion of the documentation, you're expected to be logged in as an Administrator user.**_


#### Create a user

1. Navigate to "Users" and click on "Add new"
2. Fill the required fields (username and email), leave the other fields _as-is_
3. Change the (default) role of "Subscriber" to "KISS Redacteur"
4. Finally, click "Add New User"

_Note: if you want to create another Admin user, follow the above steps and choose the role "Administrator" instead of "KISS Redacteur"._

#### Remove a user

_Note: removing a user **can not** be reverted._

1. Navigate to "Users" and hover your mouse over the target user
2. Click "Delete"
3. Optionally, assign the user's content to another account
4. Finally, click "Confirm Deletion"

### Managing publications

_Note: Users with the role "KISS Redacteur" can manage publications, an account with this role should be created as stated within #Managing users._

#### Create a publication

1. Navigate to "Publications" and click "Add New"
2. Add the following fields
   - Title: the title of the publication (required)
   - Publicatie: the content of the publication (required)
   - Publicatitetype: the type of the publication ("Nieuws" or "Werkinstructie) (required)
   - Skills: the skills relevant to this publication (optional)
   - Einddatum: the date after which the publication is no longer visible (optional; the value must be in the future if you want your publication to be shown). This field is set to 100 years in the future by default.
   - Belangrijke publicatie: check this field to mark your publication as Important. 
3. Finally, click "Publish"

#### Editing a publication

1. Navigate to the publication you want to edit by clicking on "Publications" and then clicking on the target publication
2. Edit any field that needs editing (note: you cannot remove the required fields)
3. Finally, click "Publish"

#### Removing a publication

1. Navigate to the publication you want to remove by clicking on "Publications" and then clicking on the target publication
2. Click on "Move to Trash"

_Note: removed publications can be found and restored in the trash, once the trash is emptied they can no longer be restored._

## Proxy communication via Gateway
The KISS frontend loads the list of publication types and the list of skills from the wordpress installation. For this, it uses the following api-calls. 

_Optional parameter: `per_page`._

- `GET {gateway_environment_uri}/api/openpub/openpub_type`
  _Returns all openpub_type objects within the WordPress environment, via a gateway proxy._
- `GET {gateway_environment_uri}/api/openpub/openpub_skill`
  _Returns all openpub_skill objects within the WordPress environment, via a gateway proxy._




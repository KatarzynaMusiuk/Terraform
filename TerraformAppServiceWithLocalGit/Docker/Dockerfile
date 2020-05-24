FROM mcr.microsoft.com/azure-cli

ARG terraformversion

### add env var to log into azure
ARG subscriptionId
ARG clientId
ARG clientSecret
ARG tenantId
ARG storageAccessKey
ARG appUrl
ARG gitUserName
ARG gitPassword

ENV TERRAFORM_VERSION=$terraformversion
ENV ARM_SUBSCRIPTION_ID=$subscriptionId
ENV ARM_CLIENT_ID=$clientId
ENV ARM_CLIENT_SECRET=$clientSecret
ENV ARM_TENANT_ID=$tenantId
ENV ARM_ACCESS_KEY=$storageAccessKey
ENV APP_URL=$appUrl
ENV GIT_USER_NAME=$gitUserName
ENV GIT_PASSWORD=$gitPassword
#
#
# APK stands for Alpine Linux package manager. You use the apk command to delete, install, upgrade, or list software on a running Alpine Linux based system
# Advanced Package Tool, or APT, is a free-software user interface that works with core libraries to handle the installation and removal of software on Linux
# Download curl and unzip tools - check
#
RUN apk --no-cache add curl && apk --no-cache add unzip \
#
# Install package to verify the signature file 
	&& apk --no-cache add gnupg \
#	
# Install package to run SHASUM command
	&& apk --no-cache add perl-utils \
#	
# Download keys
	&& curl https://keybase.io/hashicorp/pgp_keys.asc | gpg --import \
#	
# Download the binary and signature files.
	&& curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS \
	&& curl -Os https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig \
#	
# Verify the signature file is untampered.
	&& gpg --verify terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig terraform_${TERRAFORM_VERSION}_SHA256SUMS \
#	
# Verify the SHASUM matches the binary.
    && grep 'linux_amd64\.zip$' terraform_${TERRAFORM_VERSION}_SHA256SUMS >  terraform_${TERRAFORM_VERSION}_linux_amd64_SHA256SUMS \
	&& shasum -a 256 -c terraform_${TERRAFORM_VERSION}_linux_amd64_SHA256SUMS \
#	
# Unzip terraform move binary files to /usr/local/bin
	&& unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
#	
# Remove terraform zip and sha files  
	&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
	&& rm terraform_${TERRAFORM_VERSION}_SHA256SUMS \
	&& rm terraform_${TERRAFORM_VERSION}_SHA256SUMS.sig \
#
#
# Install git bash, 
	&& apk add --no-cache bash git openssh 

# Copy my shell file from "" to execute in entry point - the file will include git clone from the repo with the terraform file 

COPY myShellFile.sh /usr/bin
WORKDIR /usr/bin
RUN  chmod 0755 myShellFile.sh
ENTRYPOINT ["myShellFile.sh"]
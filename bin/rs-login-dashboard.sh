#! /bin/sh -e

# rs-login-dashboard.sh

# e.g. rs_server=jp-8.rightscale.com rs-login-dashboard			# logs user into the Japan shard explicitly

# Warning: This sends a request to the RightScale dashboard.
# It is not recommended to use this script for production purposes. RightScale cannot guarantee this script will work now or in the future.

[ -e "$HOME"/rightscale ] || ( mkdir -p "$HOME"/rightscale && chmod -R 700 "$HOME"/.rightscale )

. "$HOME/.rightscale/rs_api_config.sh"
. "$HOME/.rightscale/rs_api_creds.sh"

# Login to the dashboard non-interactively
url="https://$rs_server/session"
echo "GET: $url"

result=$(curl -v -s -S -c "$HOME/.rightscale/rs_dashboard_cookie.txt" -u "$rs_api_user:$rs_api_password" -d account="$rs_api_account_id" -X PUT "$url" 2>&1)

case $result in
	*"dashboard;overview"*)
		echo 'Login successful.'
		echo "Cookie was saved to $HOME/.rightscale/rs_dashboard_cookie.txt."
	;;
	*)
		echo "$result"
		echo 'Login failed!'
	;;
esac

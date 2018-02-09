Name:           omitriggertest
Version:        1
Release:        0
Summary:        rpm trigger test for omi

Group:          OMI
BuildArch:      noarch
License:        GPL
URL:            https://github.com/JumpingYang001/omi-trigger-testing
Source0:        omitriggertest.tar.gz

%description
Write some description about your package here

%prep
%setup -q -n omitriggertest
%build
%install
install -m 0755 -d $RPM_BUILD_ROOT/omitriggertest
install -m 0755 omitrigger.conf $RPM_BUILD_ROOT/omitriggertest/omitrigger.conf

%triggerin -- omi
if [ -f /opt/omi/bin/omiserver ]; then
	touch /tmp/omi_is_installed
else
	touch /tmp/omi_is_new_installed
fi

%triggerun -- omi
if [ -f /opt/omi/bin/omiserver ]; then
        touch /tmp/omi_is_updated
else
        touch /tmp/omi_is_removed
fi

%triggerpostun -- omi

%files
/omitriggertest
/omitriggertest/omitrigger.conf

%changelog
* Tue Feb 9 2018 Jumping Yang  1.0.0
  - Initial rpm release

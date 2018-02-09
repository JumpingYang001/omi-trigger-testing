cp ./omitriggertest.tar.gz /root/rpmbuild/SOURCES/omitriggertest.tar.gz
rpmbuild -ba omitriggertest.spec
cp /root/rpmbuild/RPMS/noarch/omitriggertest-1-0.noarch.rpm ./omitriggertest-1-0.noarch.rpm

git clone $pkggit /src/$pkgname-$pkgver
cd /src/$pkgname-$pkgver
git checkout $pkgcommit
export SOURCE_DATE_EPOCH=$(git log -1 --format=%ct)
build
export pkgdir=/tmp/TBD-tmp
mkdir $pkgdir
package
tar --sort=name \
      --mtime="@${SOURCE_DATE_EPOCH}" \
      --owner=0 --group=0 --numeric-owner \
      --pax-option=exthdr.name=%d/PaxHeaders/%f,delete=atime,delete=ctime \
      -cf /publish/$pkgname-$pkgver.tar $pkgdir
sha256sum=`sha256sum /publish/$pkgname-$pkgver.tar | cut -d ' ' -f1`
echo "{\"version\":\"$pkgver\",\"sha256\":\"$sha256sum\",\"timestamp\":\""`date +%s`"\"}" > /publish/$pkgname.json

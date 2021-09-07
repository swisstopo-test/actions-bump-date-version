#!/bin/sh -l

TODAY=$(date +%Y%m%d)
echo "TODAY=${TODAY}"
LAST_TODAY_TAG=$(git tag -l | awk "/${TODAY}/" | tail -1)
echo ${LAST_TODAY_TAG}
if [ -z "${LAST_TODAY_TAG}" ]
then
    NEW_TAG=${TODAY}_rc0
else
    NEW_TAG=$(${LAST_TAG} | awk -F"_rc" '{$NF+=1}{print $0RT}' OFS="_rc" ORS="")
fi
echo ${NEW_TAG}

git tag ${NEW_TAG}
git push origin ${NEW_TAG}

echo "::set-output name=new_tag::${NEW_TAG}"
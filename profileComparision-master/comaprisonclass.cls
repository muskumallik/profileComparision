public class cc {
    public String statusOptions { get; set; }
    public Set<String> leftOptions { get; set; }
    public Set<String> rightOptions { get; set; }
    public String s1 {get; set;}
    public String s2 {get; set;}
    public String profilename {get; set;}
    public List<SelectOption> getItems1() {//test
        if(leftOptions.size() != 0){
            List<SelectOption> options = new List<SelectOption>();
            for(String s: leftOptions){
                options.add(new SelectOption(s,s));
            }
            return options;
        }else{
           // leftOptions.addAll(sObjectList);asfadfasdgasf
            List<SelectOption> options = new List<SelectOption>();
            for(String s: sObjectList){
                options.add(new SelectOption(s,s));
            }
            return options;
        }
    }
    public List<SelectOption> getItems2() {
        if(rightOptions.size() >0){
            List<SelectOption> options = new List<SelectOption>();
            for(String s: rightOptions){
                options.add(new SelectOption(s,s));
                
            }
            
            return options;
        }
        else{
            return null;
        }
    }
    public set<String> objid {get; set;}
    public set<String> sObjectList {get; set;}
    public set<String> profileList {get; set;}
    public boolean s111 {get;set;}
    public set<String> objss {get; set;}
    public Map<String,comparepf> mcom {get; set;}
    public Map<String,comparepf> mcomp1 {get; set;}
    public Map<String,comparepf> mcomp2 {get; set;}
    public Map<id,Map<String,comparepf>> obmap {get; set;}
    public List<SelectOption> getItems() {
        
        List<profile> prop = [SELECT  Name from profile];
        List<SelectOption> options = new List<SelectOption>();
        for(profile p: prop){
            options.add(new SelectOption(p.Name,p.Name));
            
        }
        
        
        return options;
    }
    public void printb(){
        system.debug('**********:'+s111);
    }
    public  cc(){
        leftOptions = new set<String>();
        rightOptions = new set<String>();
        objid = new set<String>();
        objss  = new set<string>();
        mcom = new Map<String,comparepf>();
        mcomp1 = new Map<String,comparepf>();
        mcomp2 = new Map<String,comparepf>();
        sObjectList = new set<String>();
        profileList = new set<String>();
        set<String> stdobj = new set<String>{'Account','Case','Asset','Campaign','Coaching','Contact','Contract','Lead','Macro'};
            //sObjectList.addall(stdobj);
        
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values())
        {
            Schema.DescribeSObjectResult describeSObjectResultObj = objTyp.getDescribe();
            //system.debug(describeSObjectResultObj.getName());
            if(describeSObjectResultObj.isCustom())
            {
                //    objid.add(describeSObjectResultObj.getName());
                //SobjectList.add(describeSObjectResultObj.getLabel());
            }else{//SobjectList.add(describeSObjectResultObj.getName());
            }
            comparepf cc = new comparepf();
            objss.add(describeSObjectResultObj.getName());
            
        }
        profilename = 'System Administrator';
        mcomp1 = getProfileCompare(profilename);
        // getProfileCompare();
    }
    /* public void add(){
for(String s:leftOptions){
rightOptions.add(s);
getItems1.remove(s);
}
}*/
public void remove(){
 s111 = true;
}
public void add(){
 s111 = false;
}

    public  Map<String,comparepf> getProfileCompare(String s){
        List<ObjectPermissions> oP=[  SELECT  parentId, SObjectType, PermissionsRead, PermissionsCreate, 
                                    PermissionsDelete,PermissionsEdit,  PermissionsViewAllRecords, PermissionsModifyAllRecords
                                    FROM ObjectPermissions 
                                    WHERE parentid in (select id from permissionset where
                                                       PermissionSet.Profile.Name =: s )];
        
        Map<String,comparepf> mmpf = new  Map<String,comparepf>();
        for(ObjectPermissions o: oP){
            SobjectList.add(o.SObjectType);
            comparepf zcom = new comparepf();
            zcom.PermissionsRead = o.PermissionsRead;
            zcom.PermissionsCreate = o.PermissionsCreate;
            zcom.PermissionsDelete = o.PermissionsDelete;
            zcom.PermissionsEdit = o.PermissionsEdit;
            zcom.PermissionsViewAllRecords = o.PermissionsViewAllRecords;
            zcom.PermissionsModifyAllRecords = o.PermissionsModifyAllRecords;
            //String recordTypeId = Schema.getGlobalDescribe().get(o.sobjecttype).getDescribe().getlabel();
           // SobjectList.add(Schema.getGlobalDescribe().get(o.sobjecttype).getDescribe().getlabel());
            mmpf.put(recordTypeId,zcom);
        }
        for(String s11: sObjectList){
            comparepf zcom = new comparepf();
            if(!mmpf.containskey(s11)){
                zcom.PermissionsRead = false;
                zcom.PermissionsCreate = false;
                zcom.PermissionsDelete = false;
                zcom.PermissionsEdit = false;
                zcom.PermissionsViewAllRecords = false;
                zcom.PermissionsModifyAllRecords = false;
                mmpf.put(s11, zcom);
            }
        }
        return mmpf;
    }
    public void profdownld(){
    profilename = ApexPages.currentPage().getParameters().get('id');
    mcomp1 = getProfileCompare(profilename);
    }
    public void retm(){
        mcomp1 = getProfileCompare(s1);
        mcomp2 = getProfileCompare(s2);
        for(String s:SobjectList){
            if(mcomp1  != null && mcomp2 != null){
                comparepf firstpp = mcomp1.get(s);
                comparepf sspp = mcomp2.get(s);
                comparepf oopp = new comparepf();
                if(firstpp.PermissionsRead == sspp.PermissionsRead){
                    oopp.PermissionsRead = true;
                }else{oopp.PermissionsRead = false;}
                if(firstpp.PermissionsDelete== sspp.PermissionsDelete){
                    oopp.PermissionsDelete= true;
                }else{oopp.PermissionsDelete= false;}
                if(firstpp.PermissionsCreate == sspp.PermissionsCreate){
                    oopp.PermissionsCreate = true;
                }else{oopp.PermissionsCreate = false;}
                if(firstpp.PermissionsEdit == sspp.PermissionsEdit){
                    oopp.PermissionsEdit = true;
                }else{oopp.PermissionsEdit = false;}
                if(firstpp.PermissionsViewAllRecords == sspp.PermissionsViewAllRecords){
                    oopp.PermissionsViewAllRecords = true;
                }else{oopp.PermissionsViewAllRecords = false;}
                if(firstpp.PermissionsModifyAllRecords == sspp.PermissionsModifyAllRecords){
                    oopp.PermissionsModifyAllRecords = true;
                }else{oopp.PermissionsModifyAllRecords = false;} mcom.put(s, oopp);
            }
            
        }
        
    }
    public class comparepf{
        public Boolean PermissionsRead{get; set;}
        public Boolean PermissionsCreate{get; set;}
        public Boolean PermissionsDelete{get; set;}
        public Boolean PermissionsEdit{get; set;}
        public Boolean PermissionsViewAllRecords{get; set;}
        public Boolean PermissionsModifyAllRecords{get; set;}
        
    }
}

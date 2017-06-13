
package org.roag.model;

import java.util.List;
import javax.annotation.Generated;
import com.google.gson.annotations.SerializedName;

@Generated("net.hexar.json2pojo")
@SuppressWarnings("unused")
public class Subscriber {

//    @SerializedName("_id")
//    private String mId;
    @SerializedName("email")
    private String mEmail;
    @SerializedName("name")
    private String mName;
    @SerializedName("rsslist")
    private List<Rss> mRsslist;
    @SerializedName("settings")
    private Settings mSettings;
    @SerializedName("status")
    private String mStatus;


//    public String getId()
//    {
//        return mId;
//    }

//    public void setId(String _id)
//    {
//        this.mId = _id;
//    }

    public String getEmail() {
        return mEmail;
    }

    public void setEmail(String email) {
        mEmail = email;
    }

    public String getName() {
        return mName;
    }

    public void setName(String name) {
        mName = name;
    }

    public List<Rss> getRsslist() {
        return mRsslist;
    }

    public void setRsslist(List<Rss> rsslist) {
        mRsslist = rsslist;
    }

    public Settings getSettings() {
        return mSettings;
    }

    public void setSettings(Settings settings) {
        mSettings = settings;
    }

    public String getStatus() {
        return mStatus;
    }

    public void setStatus(String status) {
        mStatus = status;
    }

}
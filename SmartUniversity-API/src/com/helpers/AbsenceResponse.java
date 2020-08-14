package com.helpers;

import java.util.ArrayList;

import javax.xml.bind.annotation.XmlRootElement;

import com.modele.Absence;
import com.modele.Justification;

@XmlRootElement
public class AbsenceResponse
{
	private Absence absence = null;
	private boolean isJustifier = false;
	private ArrayList<Justification> justifications = null;
	
	public AbsenceResponse(Absence absence, boolean isJustifier, ArrayList<Justification> justifications)
	{
		this.absence = absence;
		this.isJustifier = isJustifier;
		this.justifications = justifications;
	}

	public AbsenceResponse()
	{
		
	}

	public Absence getAbsence()
	{
		return absence;
	}

	public boolean isJustifier()
	{
		return isJustifier;
	}

	public ArrayList<Justification> getJustifications()
	{
		return justifications;
	}

	public void setAbsence(Absence absence)
	{
		this.absence = absence;
	}

	public void setJustifier(boolean isJustifier)
	{
		this.isJustifier = isJustifier;
	}

	public void setJustifications(ArrayList<Justification> justifications)
	{
		this.justifications = justifications;
	}
}

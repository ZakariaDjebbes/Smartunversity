package com.helpers;

import com.modele.Absence;
import com.modele.Justification;

public class AbsenceResponse
{
	private Absence absence = null;
	private boolean isJustifier = false;
	private Justification justification = null;
	
	public AbsenceResponse(Absence absence, boolean isJustifier, Justification justification)
	{
		this.absence = absence;
		this.isJustifier = isJustifier;
		this.justification = justification;
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

	public Justification getJustification()
	{
		return justification;
	}

	public void setAbsence(Absence absence)
	{
		this.absence = absence;
	}

	public void setJustifier(boolean isJustifier)
	{
		this.isJustifier = isJustifier;
	}

	public void setJustification(Justification justification)
	{
		this.justification = justification;
	}
}

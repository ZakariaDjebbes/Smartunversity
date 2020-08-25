package com.utility;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import com.helpers.AbsenceDepartementResponse;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;

public class ReleverAbsencesEtudiant
{
	private HashMap<String, ArrayList<AbsenceDepartementResponse>> relever;

	public ReleverAbsencesEtudiant(HashMap<String, ArrayList<AbsenceDepartementResponse>> relever)
	{
		this.relever = relever;
	}

	public HashMap<String, ArrayList<AbsenceDepartementResponse>> getRelever()
	{
		return relever;
	}

	public void setRelever(HashMap<String, ArrayList<AbsenceDepartementResponse>> relever)
	{
		this.relever = relever;
	}

	public static ReleverAbsencesEtudiant GetReleverFromAbsences(ArrayList<AbsenceDepartementResponse> absences)
	{
		HashSet<String> codes = new HashSet<String>();
		HashMap<String, ArrayList<AbsenceDepartementResponse>> relever = new HashMap<String, ArrayList<AbsenceDepartementResponse>>();

		for (AbsenceDepartementResponse absence : absences)
		{
			codes.add(absence.getSeance().getCode_seance());
		}

		for (String code : codes)
		{
			ArrayList<AbsenceDepartementResponse> thisCodeAbsences = new ArrayList<AbsenceDepartementResponse>();

			for (AbsenceDepartementResponse absence : absences)
			{
				if (absence.getSeance().getCode_seance().equals(code))
				{
					thisCodeAbsences.add(absence);
				}
			}

			relever.put(code, thisCodeAbsences);
		}

		return new ReleverAbsencesEtudiant(relever);
	}

	public boolean isEmpty()
	{
		return relever.isEmpty();
	}

	public int getNombreAbsences(String code_seance)
	{
		if (relever.get(code_seance) == null)
		{
			return 0;
		}
		return relever.get(code_seance).size();
	}

	public boolean isExcluFrom(String code_seance)
	{
		ArrayList<AbsenceDepartementResponse> absences = relever.get(code_seance) == null
				? new ArrayList<AbsenceDepartementResponse>()
				: relever.get(code_seance);
		int absencesNonJustifier = 0;
		if (absences.size() == 0)
		{
			return false;
		} else
		{
			for (AbsenceDepartementResponse absence : absences)
			{
				ArrayList<Justification> justifications = absence.getJustifications();
				if (justifications.size() > 0)
				{
					for (int i = 0; i < justifications.size(); i++)
					{
						Justification justification = justifications.get(i);
						// TODO non traiter = exlu ou nn?
						boolean isJustifier = justification.getEtat_justification() == Etat_Demande.valide;

						if (i == justifications.size() - 1 && !isJustifier)
						{
							absencesNonJustifier++;
							break;
						}
					}
				} else
				{
					absencesNonJustifier++;
				}
			}
		}

		if (absencesNonJustifier >= 3 || absences.size() >= 5)
		{
			return true;
		}
		return false;
	}
}

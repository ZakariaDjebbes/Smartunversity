package com.utility;

import java.security.SecureRandom;
import java.util.ArrayList;

import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import com.data.DAO_Justification;
import com.helpers.AbsenceResponse;
import com.helpers.EtudiantResponse;
import com.modele.Absence;
import com.modele.Etudiant;
import com.modele.Etudiant.Etat_Etudiant;
import com.modele.Etudiant.Specialite;
import com.modele.Justification;
import com.modele.Seance.Etat_Demande;
import com.modele.Utilisateur.Code_Departement;

public class Utility
{
	public static <T> Response Response(Status status, T entity)
	{
		return Response.status(status).entity(entity).build();
	}

	public static <E extends Enum<E>> boolean IsInEnum(String value, Class<E> enumClass)
	{
		for (E e : enumClass.getEnumConstants())
		{
			if (e.name().equals(value))
			{
				return true;
			}
		}
		return false;
	}

	public static boolean HourExists(String heure)
	{
		if (!heure.equals("8:30") && !heure.equals("10:00") && !heure.equals("11:30") && !heure.equals("13:00")
				&& !heure.equals("14:30"))
			return false;

		return true;
	}

	public static String generateRandomString(int length)
	{
		final String ALPHABET = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		SecureRandom random = new SecureRandom();
		StringBuilder builder = new StringBuilder(length);

		for (int i = 0; i < length; i++)
		{
			builder.append(ALPHABET.charAt(random.nextInt(ALPHABET.length())));
		}

		return builder.toString();
	}

	public static ArrayList<Specialite> GetSpecialitesOfDepartement(Code_Departement code_departement) throws Exception
	{
		ArrayList<Specialite> result = new ArrayList<Specialite>();

		switch (code_departement)
		{
		case MI:
			result.add(Specialite.MI);
			break;
		case TLSI:
			result.add(Specialite.GL);
			result.add(Specialite.SI);
			result.add(Specialite.STIW);
			break;
		case IFA:
			result.add(Specialite.SCI);
			result.add(Specialite.TI);
			result.add(Specialite.RSD);
			result.add(Specialite.STIC);
			break;
		default:
			throw new Exception("Unrecognized code_departement in com.helpers.Utility.GetSpecialitesOfDepartement");
		}

		return result;
	}

	public static Code_Departement GetDepartementOfSpecialite(Specialite specialite)
	{
		switch (specialite)
		{
		case MI:
			return Code_Departement.MI;
		case SI:
		case STIW:
		case GL:
			return Code_Departement.TLSI;
		case SCI:
		case TI:
		case RSD:
		case STIC:
			return Code_Departement.IFA;
		}

		return Code_Departement.MI;
	}

	public static ArrayList<Code_Departement> GetAvailabeDepartementsOfDepartement(Code_Departement code_departement)
	{
		ArrayList<Code_Departement> codes = new ArrayList<Code_Departement>();

		switch (code_departement)
		{
		case MI:
			codes.add(Code_Departement.MI);
			codes.add(Code_Departement.TLSI);
			codes.add(Code_Departement.IFA);
			break;
		case TLSI:
			codes.add(Code_Departement.MI);
			codes.add(Code_Departement.TLSI);
			break;
		case IFA:
			codes.add(Code_Departement.MI);
			codes.add(Code_Departement.IFA);
			break;
		}

		return codes;
	}

	public static EtudiantResponse GetEtudiantResponse(ArrayList<Absence> absences, Etudiant etudiant)
	{
		EtudiantResponse etudiantResponse = new EtudiantResponse();
		etudiantResponse.setEtudiant(etudiant);
		
		int absencesJustifier = 0;
		int absencesNonJustifier = 0;

		if (absences.size() == 0)
		{
			absences = null;
		} else
		{
			// getting justifications
			ArrayList<AbsenceResponse> absencesResponse = new ArrayList<AbsenceResponse>();

			// foreach absence get justifications
			for (Absence absence : absences)
			{
				AbsenceResponse absenceResponse = new AbsenceResponse();
				absenceResponse.setAbsence(absence);

				ArrayList<Justification> justifications = DAO_Justification
						.GetJustificationsByAbsence(absence.getNumero_absence());

				if (justifications.size() != 0)
				{
					for (int i = 0; i < justifications.size(); i++)
					{
						Justification justification = justifications.get(i);
						// TODO non traiter = exlu ou nn?
						boolean isJustifier = justification.getEtat_justification() == Etat_Demande.valide;
						if (isJustifier)
						{
							absenceResponse.setJustifier(true);
							absencesJustifier++;
							break;
						}

						if (i == justifications.size() - 1 && !isJustifier)
						{
							absenceResponse.setJustifier(false);
							absencesNonJustifier++;
							break;
						}
					}
					absenceResponse.setJustifications(justifications);
				} else
				{
					absencesNonJustifier++;
					absenceResponse.setJustifications(null);
					absenceResponse.setJustifier(false);
				}

				absencesResponse.add(absenceResponse);
			}

			if (absencesNonJustifier >= 3 || absences.size() >= 5 || etudiant.getEtat_etudiant() == Etat_Etudiant.bloque)
			{
				etudiantResponse.setExclus(true);
			} else
			{
				etudiantResponse.setExclus(false);
			}

			// setting the absences numbers
			etudiantResponse.setNombreAbsences(absencesResponse.size());
			etudiantResponse.setAbsencesJusifiter(absencesJustifier);
			etudiantResponse.setAbsencesNonJustifier(absencesNonJustifier);

			// setting the absences data
			etudiantResponse.setAbsences(absencesResponse);
		}
		
		return etudiantResponse;
	}
}
